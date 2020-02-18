class AnimalsController < ApplicationController

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
                      :animal_species => cookies[:search_animal_species],}
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
    end


    @search_animal = Animal.ransack(params[:q])
    @animals = @search_animal.result(distinct: true)
  end

  def show
  end

  def edit
  end

  def new
  end

  private
  def search_params
    params.require(:q).permit(:name,
                              :binomial_name,
                              :animal_class,
                              :animal_order,
                              :animal_family,
                              :animal_genus,
                              :animal_species)
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end
end
