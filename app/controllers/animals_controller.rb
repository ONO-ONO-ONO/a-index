class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update]

  def index
    # pathを取得できるようにする
    path =  Rails.application.routes.recognize_path(request.referrer)

    # animal画面にいる際にはクッキーが残るように設定/animal画面外ではクッキー削除
    if path[:controller] == "animal"
      if params[:q].nil?
        params[:q] = {:name => cookies[:search_name],
                      :binomial_name => cookies[:search_binomial_name],
                      :animal_class => cookies[:search_animal_class],
                      :animal_order => cookies[:search_animal_order],
                      :animal_family => cookies[:search_animal_family],
                      :animal_genus => cookies[:search_animal_genus],
                      :animal_species => cookies[:search_animal_species],
                      :animal_sub_species => cookies[:search_animal_sub_species]}
        # params[:page] = cookies[:animal_page] if params[:page].nil?
      else
        # cookies.delete :animal_page
      end
    else
      cookies.delete :search_name
      cookies.delete :search_binomial_name
      cookies.delete :search_animal_class
      cookies.delete :search_animal_order
      cookies.delete :search_animal_family
      cookies.delete :search_animal_genus
      cookies.delete :search_animal_species
      cookies.delete :search_animal_sub_species
    end

    #set cookies
    if params[:q] != nil
      cookies[:search_name] = params[:q][:name]
      cookies[:search_binomial_name] = params[:q][:binomial_name]
      cookies[:search_animal_class] = params[:q][:animal_class]
      cookies[:search_animal_order] = params[:q][:animal_order]
      cookies[:search_animal_family] = params[:animal_family]
      cookies[:search_animal_genus] = params[:q][:animal_genus]
      cookies[:search_animal_species] = params[:q][:animal_species]
      cookies[:search_animal_sub_species] = params[:q][:animal_sub_species]
    end

    # Ransack用意
    @search_animal = Animal.ransack(params[:q])
    @animals = @search_animal.result(distinct: true)
  end

  def show
    @animal_images = AnimalImage.where(animal_id: params[:id])
  end

  def new
    @animal = Animal.new
    @animal.build_animal_distribution
    @animal.build_animal_habitat
  end

  def edit
    @animal_images = AnimalImage.where(animal_id: params[:id])
    @animal_image = AnimalImage.new
  end

  def create
    animal = Animal.new(animal_params)

    # [WIP]クリエイトユーザー・アップデートユーザーのコード
    # @user = current_user
    # @animal.created_user = current_user.id
    # @animal.updated_user = current_user.id

    if animal.name.present?
      animal.save
      # =================== 動物の分布を登録する ===================
      params[:animal_distribution][:distribution].each do |d|
        animal_distribution = AnimalDistribution.new
        animal_distribution.animal_id = animal.id
        animal_distribution.distribution = d
        animal_distribution.save if animal_distribution.distribution.present?
      end

      # =================== 動物の生息地を登録する ===================
      params[:animal_habitat][:habitat].each do |h|
        animal_habitat = AnimalHabitat.new
        animal_habitat.animal_id = animal.id
        animal_habitat.habitat = h
        animal_habitat.save if animal_habitat.habitat.present?
      end

      redirect_to animal, notice: '作成しました。'
    else
      redirect_to ({controller: 'animals', action: 'new'}), alert: '保存できませんでした'
    end
  end

  # [WIP]分布を登録する辺りが現在少し不自然、後日対応予定
  def update

    # [WIP]アップデートユーザーのコード
    # @animal.updated_user = current_user.id

    if @animal.update(animal_params)

      # =========================== 分布 ===========================
      # 入力した分布の数量カウント(each文用)
      disr_count = 0
      # 入力した分布の配列(空欄含む)
      dbox = params[:animal_distribution][:distribution]

      # each文を5回周す(空欄含む)
      dbox.each do |d|

        # 既存の記載分布内容は更新をかける（disr_count + 1 はboxの周回数, @distributions.countは今までの記載数）
        if (disr_count + 1) <= @distributions.count
          @distributions[disr_count].animal_id = @animal.id
          @distributions[disr_count].distribution = d

          # 既存の記載分布が空欄に代わっていた場合はレコード削除する(ここがバグってる可能性 大 )
          @distributions[disr_count].destroy if d.empty?
          @distributions[disr_count].save

        # 新規の記載分布はnewで新たにレコード作成
        elsif (disr_count + 1) > @distributions.count && d.present?
          new_animal_distribution = AnimalDistribution.new
          new_animal_distribution.animal_id = @animal.id
          new_animal_distribution.distribution = d
          new_animal_distribution.save
        end

        # 次の周回にむけてcountを1増やす
        disr_count += 1
      end

      # =========================== 生息地 ===========================
      # 入力した分布の数量カウント(each文用)
      habi_count = 0
      # 入力した分布の配列(空欄含む)
      hbox = params[:animal_habitat][:habitat]

      # each文を5回周す(空欄含む)
      hbox.each do |h|

        # 既存の記載分布内容は更新をかける（habi_count + 1 はboxの周回数, @habitats.countは今までの記載数）
        if (habi_count + 1) <= @habitats.count
          @habitats[habi_count].animal_id = @animal.id
          @habitats[habi_count].habitat = h

          # 既存の記載分布が空欄に代わっていた場合はレコード削除する(ここがバグってる可能性 大 )
          @habitats[habi_count].destroy if h.empty?
          @habitats[habi_count].save

        # 新規の記載分布はnewで新たにレコード作成
        elsif (habi_count + 1) > @habitats.count && h.present?
          new_animal_habitat = AnimalHabitat.new
          new_animal_habitat.animal_id = @animal.id
          new_animal_habitat.habitat = h
          new_animal_habitat.save
        end

        # 次の周回にむけてcountを1増やす
        habi_count += 1
      end

      redirect_to @animal, notice: '更新しました'
    else
      render :edit
    end
  end


  def animal_image_upload
    animal_image = params.require(:animal_image).permit(:animal_id, :image)
    if animal_image.empty?
      redirect_to ({controller: 'animals', action: 'edit', id: animal_image['animal_id']}), notice: '画像の追加に失敗しました。'
      return
    end
    @animal_image = AnimalImage.new(
        animal_id: animal_image['animal_id'],
        image: animal_image['image'],
        # created_user: current_user.id,
        # updated_user: current_user.id,
      )

    @animal_image.save

    redirect_to ({controller: 'animals', action: 'edit', id: animal_image['animal_id']}), notice: '画像が追加されました。'
  end

  def remove_image
    AnimalImage.destroy(params[:format])
    redirect_to ({controller: 'animals', action: 'index'}),notice: '画像が削除されました。'
  end




  private
  def set_animal
    @animal = Animal.find(params[:id])

    # AnimalとAnimalDistribution(分布)
    @distributions = AnimalDistribution.where(animal_id: @animal.id)
    @animal_distributions = []
    @distributions.each do |a_distribution|
      @animal_distributions.push(a_distribution.distribution)
    end

    # AnimalとAnimalHabitat(生息地)
    @habitats = AnimalHabitat.where(animal_id: @animal.id)
    @animal_habitats = []
    @habitats.each do |a_habitat|
      @animal_habitats.push(a_habitat.habitat)
    end
  end

  def animal_params
    params.require(:animal).permit(:name,
                                   :binomial_name,
                                   :animal_class,
                                   :animal_order,
                                   :animal_family,
                                   :animal_genus,
                                   :animal_species,
                                   :animal_sub_species,
                                   :min_length,
                                   :max_length,
                                   :min_weight,
                                   :max_weight,
                                   :distribution,
                                   animal_distribution_attributes:[:id, :distribution],
                                   animal_habitat_attributes:[:id, :habitat],
                                   animal_image_attributes:[:id, :image]
                                    )
        end
end
