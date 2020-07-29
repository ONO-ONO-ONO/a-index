class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update]
  before_action :role_admin
  before_action :role_admin_redirect, only: [:new, :edit, :create, :update]

  def index
    # Ransack用意
    @search_animal = Animal.ransack(params[:q])
    @animals = @search_animal.result(distinct: true).page(params[:page])

    # ページネーションAjax設定
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @animal_images = AnimalImage.where(animal_id: params[:id])
  end

  def new
    @animal = Animal.new
    @animal.build_animal_distribution
    @animal.build_animal_habitat
    @save_button = "登録"
    @animal_distributions = ["", "", "", "", ""]
    @animal_habitats = ["", "", "", "", ""]
  end

  def edit
    @animal_images = AnimalImage.where(animal_id: params[:id])
    @animal_image = AnimalImage.new
    @save_button = "更新"
    @images_save_button = "登録"
  end

  def create
    # @animal = Animal.new(animal_params)
    # if @animal.save
    #   redirect_to @animal, notice: '作成しました。'
    # else
    #   render "new"
    # end
    
    @animal = Animal.new(animal_params)

    @animal.created_user = current_account.id
    @animal.updated_user = current_account.id

    if @animal.save

      # # 分布のバリデーション確認
      # if params[:animal_distribution][:distribution][0].length >= 15 || params[:animal_distribution][:distribution][1].length >= 15 || params[:animal_distribution][:distribution][2].length >= 15 || params[:animal_distribution][:distribution][3].length >= 15 || params[:animal_distribution][:distribution][4].length >= 15
      #   @animal = Animal.new(animal_params) #newで入力した値を代入
      #   @animal_distributions = params[:animal_distribution][:distribution]
      #   @animal_habitats = params[:animal_habitat][:habitat]
      #   flash.now[:alert] = "分布は15文字以内で入力してください"
      #   render 'new' 
      #   return
      # end
      # # 生息地のバリデーション確認
      # if params[:animal_habitat][:habitat][0].length >= 15 || params[:animal_habitat][:habitat][1].length >= 15 || params[:animal_habitat][:habitat][2].length >= 15 || params[:animal_habitat][:habitat][3].length >= 15 || params[:animal_habitat][:habitat][4].length >= 15
      #   @animal = Animal.new(animal_params) #newで入力した値を代入
      #   @animal_distributions = params[:animal_distribution][:distribution]
      #   @animal_habitats = params[:animal_habitat][:habitat]
      #   flash.now[:alert] = "生息地は15文字以内で入力してください"
      #   render 'new' 
      #   return
      # end

      # @animal.save
      # # =================== 動物の分布を登録する ===================
      # params[:animal_distribution][:distribution].each do |d|
      #   animal_distribution = AnimalDistribution.new
      #   animal_distribution.animal_id = @animal.id
      #   animal_distribution.distribution = d
      #   animal_distribution.save if animal_distribution.distribution.present?
      # end

      # # =================== 動物の生息地を登録する ===================
      # params[:animal_habitat][:habitat].each do |h|
      #   animal_habitat = AnimalHabitat.new
      #   animal_habitat.animal_id = @animal.id
      #   animal_habitat.habitat = h
      #   animal_habitat.save if animal_habitat.habitat.present?
      # end

      redirect_to @animal, notice: '作成しました。'
    else
      # animal_alert = @animal
      # @animal = Animal.new(animal_params) #newで入力した値を代入
      # @animal_distributions = params[:animal_distribution][:distribution]
      # @animal_habitats = params[:animal_habitat][:habitat]
      # flash.now[:alert] = animal_alert.errors.full_messages.first
      render 'new'
    end
  end

  # [WIP]分布を登録する辺りが現在少し不自然、後日対応予定
  def update
    
    animal_valid = Animal.new(animal_params)
    if animal_valid.valid?

      # 分布のバリデーション確認
      if params[:animal_distribution][:distribution][0].length >= 15 || params[:animal_distribution][:distribution][1].length >= 15 || params[:animal_distribution][:distribution][2].length >= 15 || params[:animal_distribution][:distribution][3].length >= 15 || params[:animal_distribution][:distribution][4].length >= 15
        @animal = Animal.new(animal_params) #newで入力した値を代入
        @animal_distributions = params[:animal_distribution][:distribution]
        @animal_habitats = params[:animal_habitat][:habitat]
        flash.now[:alert] = "分布は15文字以内で入力してください"
        render 'new' 
        return
      end
      # 生息地のバリデーション確認
      if params[:animal_habitat][:habitat][0].length >= 15 || params[:animal_habitat][:habitat][1].length >= 15 || params[:animal_habitat][:habitat][2].length >= 15 || params[:animal_habitat][:habitat][3].length >= 15 || params[:animal_habitat][:habitat][4].length >= 15
        @animal = Animal.new(animal_params) #newで入力した値を代入
        @animal_distributions = params[:animal_distribution][:distribution]
        @animal_habitats = params[:animal_habitat][:habitat]
        flash.now[:alert] = "生息地は15文字以内で入力してください"
        render 'new' 
        return
      end

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
      @animal.update(animal_params)
      @animal.updated_user = current_account.id
      redirect_to @animal, notice: '更新しました'

    else
      animal_alert = animal_valid
      @animal_distributions = params[:animal_distribution][:distribution]
      @animal_habitats = params[:animal_habitat][:habitat]
      flash.now[:alert] = animal_alert.errors.full_messages.first
      render 'edit'
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

  def role_admin
    if account_signed_in?
      if current_account.role < 50
        @admin_view_display = false
      elsif current_account.role >= 90
        @admin_view_display = true
      end
    end

    unless  account_signed_in?
      @admin_view_display = false
    end

  end


  def role_admin_redirect
    if account_signed_in?
      if current_account.role < 50
        redirect_to ({controller: 'animals', action: 'index'}),alert: 'アクセス権限がありません'
      end
    end

    unless  account_signed_in?
      redirect_to ({controller: 'animals', action: 'index'}),alert: 'アクセス権限がありません'
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
