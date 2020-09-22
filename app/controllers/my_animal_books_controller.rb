class MyAnimalBooksController < ApplicationController
  before_action :ex_temporary_registration
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
  end

  def edit
  end

  def create
    @my_animal = MyAnimalBook.new(my_animal_params)
    @my_animal.user_id = current_account.id
    if @my_animal.save
      redirect_to @my_animal, notice: '作成しました。'
    else 
      render 'new'
    end

  end

  def update
    @my_animal = MyAnimalBook.find(params[:id])
    if @my_animal.update(my_animal_params)
      redirect_to @my_animal, notice: '更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @my_animal = MyAnimalBook.find(params[:id])
    @my_animal.destroy
    redirect_to my_animal_books_path, notice: '削除しました。'

  end

  private
  def set_my_animal
    @my_animal = MyAnimalBook.find(params[:id])
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
