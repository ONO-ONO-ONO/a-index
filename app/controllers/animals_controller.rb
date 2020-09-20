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
  end

  def edit
    @edit_animal_images = AnimalImage.where(animal_id: params[:id])
    @new_animal_image = AnimalImage.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.created_user = current_account.id
    @animal.updated_user = current_account.id
    if @animal.save
      redirect_to @animal, notice: '作成しました。'
    else 
      render 'new'
    end
  end

  def update
    @animal = Animal.find(params[:id])
    @animal.created_user = current_account.id
    @animal.updated_user = current_account.id
    if @animal.update(animal_params)
      redirect_to @animal, notice: '作成しました。'
    else
      @edit_animal_images = AnimalImage.where(animal_id: params[:id])
      @new_animal_image = AnimalImage.new
      render 'edit'
    end
  end

  def animal_image_upload
    upload_image = params.require(:animal_image).permit(:animal_id, :image)
    new_animal_image = AnimalImage.new(animal_id: upload_image['animal_id'], image: upload_image['image'])
    if new_animal_image.save
      redirect_to ({controller: 'animals', action: 'edit', id: new_animal_image['animal_id']}), notice: '画像が追加されました。'
    else
      redirect_to ({controller: 'animals', action: 'edit', id: new_animal_image['animal_id']}), alert: new_animal_image.errors.full_messages_for(:image)[0]
    end   
  end

  def remove_image
    redirect_animal_id = AnimalImage.find(params[:format]).animal_id
    AnimalImage.destroy(params[:format])
    redirect_to ({controller: 'animals', action: 'edit', id: redirect_animal_id}),notice: '画像が削除されました。'
  end


  private
  def set_animal
    @animal = Animal.find(params[:id])
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
                                   :distribution_1,
                                   :distribution_2,
                                   :distribution_3,
                                   :distribution_4,
                                   :distribution_5,
                                   :habitat_1,
                                   :habitat_2,
                                   :habitat_3,
                                   :habitat_4,
                                   :habitat_5,
                                   :red_list,
                                   animal_image_attributes:[:id, :image]
                                    )
  end

  # 権限管理
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

  # [:new, :edit, :create, :update]に対応
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
  
end
