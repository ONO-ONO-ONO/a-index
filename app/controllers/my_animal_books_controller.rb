class MyAnimalBooksController < ApplicationController
  before_action :set_my_animal, only: [:show, :edit, :update]
  before_action :authenticate_account! #これでaccounts/sign_inへリダイレクト

  def index
    # Ransack用意
    @search_my_animal = MyAnimalBook.ransack(params[:q])
    # ログインアカウントのMyAnimalのみ取得する　=.where(user_id: current_account.id))
    @my_animals = @search_my_animal.result(distinct: true).where(user_id: current_account.id)
  end

  def show
    @animal_images = AnimalImage.where(animal_id: params[:id])
  end

  def new
    @my_animal = MyAnimalBook.new
    @account_id = current_account.id
    @save_button = "登録"
  end

  def edit
    @save_button = "更新"
  end

  def create
    my_animal = MyAnimalBook.new(my_animal_params)

    if my_animal.save
      redirect_to my_animal, notice: '作成しました。'
    end


    #   animal.save
    #   # =================== 動物の分布を登録する ===================
    #   params[:animal_distribution][:distribution].each do |d|
    #     animal_distribution = AnimalDistribution.new
    #     animal_distribution.animal_id = animal.id
    #     animal_distribution.distribution = d
    #     animal_distribution.save if animal_distribution.distribution.present?
    #   end

    #   # =================== 動物の生息地を登録する ===================
    #   params[:animal_habitat][:habitat].each do |h|
    #     animal_habitat = AnimalHabitat.new
    #     animal_habitat.animal_id = animal.id
    #     animal_habitat.habitat = h
    #     animal_habitat.save if animal_habitat.habitat.present?
    #   end

    #   redirect_to animal, notice: '作成しました。'
    # else
    #   redirect_to ({controller: 'animals', action: 'new'}), alert: '保存できませんでした'
    # end
  end

  # # [WIP]分布を登録する辺りが現在少し不自然、後日対応予定
  # def update

  #   # [WIP]アップデートユーザーのコード
  #   # @animal.updated_user = current_user.id

  #   if @animal.update(animal_params)

  #     # =========================== 分布 ===========================
  #     # 入力した分布の数量カウント(each文用)
  #     disr_count = 0
  #     # 入力した分布の配列(空欄含む)
  #     dbox = params[:animal_distribution][:distribution]

  #     # each文を5回周す(空欄含む)
  #     dbox.each do |d|

  #       # 既存の記載分布内容は更新をかける（disr_count + 1 はboxの周回数, @distributions.countは今までの記載数）
  #       if (disr_count + 1) <= @distributions.count
  #         @distributions[disr_count].animal_id = @animal.id
  #         @distributions[disr_count].distribution = d

  #         # 既存の記載分布が空欄に代わっていた場合はレコード削除する(ここがバグってる可能性 大 )
  #         @distributions[disr_count].destroy if d.empty?
  #         @distributions[disr_count].save

  #       # 新規の記載分布はnewで新たにレコード作成
  #       elsif (disr_count + 1) > @distributions.count && d.present?
  #         new_animal_distribution = AnimalDistribution.new
  #         new_animal_distribution.animal_id = @animal.id
  #         new_animal_distribution.distribution = d
  #         new_animal_distribution.save
  #       end

  #       # 次の周回にむけてcountを1増やす
  #       disr_count += 1
  #     end

  #     # =========================== 生息地 ===========================
  #     # 入力した分布の数量カウント(each文用)
  #     habi_count = 0
  #     # 入力した分布の配列(空欄含む)
  #     hbox = params[:animal_habitat][:habitat]

  #     # each文を5回周す(空欄含む)
  #     hbox.each do |h|

  #       # 既存の記載分布内容は更新をかける（habi_count + 1 はboxの周回数, @habitats.countは今までの記載数）
  #       if (habi_count + 1) <= @habitats.count
  #         @habitats[habi_count].animal_id = @animal.id
  #         @habitats[habi_count].habitat = h

  #         # 既存の記載分布が空欄に代わっていた場合はレコード削除する(ここがバグってる可能性 大 )
  #         @habitats[habi_count].destroy if h.empty?
  #         @habitats[habi_count].save

  #       # 新規の記載分布はnewで新たにレコード作成
  #       elsif (habi_count + 1) > @habitats.count && h.present?
  #         new_animal_habitat = AnimalHabitat.new
  #         new_animal_habitat.animal_id = @animal.id
  #         new_animal_habitat.habitat = h
  #         new_animal_habitat.save
  #       end

  #       # 次の周回にむけてcountを1増やす
  #       habi_count += 1
  #     end

  #     redirect_to @animal, notice: '更新しました'
  #   else
  #     render :edit
  #   end
  # end


  private
  def set_my_animal
    @my_animal = MyAnimalBook.find(params[:id])

    # # AnimalとAnimalDistribution(分布)
    # @distributions = AnimalDistribution.where(animal_id: @animal.id)
    # @animal_distributions = []
    # @distributions.each do |a_distribution|
    #   @animal_distributions.push(a_distribution.distribution)
    # end

    # # AnimalとAnimalHabitat(生息地)
    # @habitats = AnimalHabitat.where(animal_id: @animal.id)
    # @animal_habitats = []
    # @habitats.each do |a_habitat|
    #   @animal_habitats.push(a_habitat.habitat)
    # end
  end

  def my_animal_params
    params.require(:my_animal_book).permit(:user_id,
                                      :my_animal_name,
                                      :my_animal_place,
                                      :my_animal_detail,
                                      :check,
                                      :my_animal_image
                                      )
    end
end
