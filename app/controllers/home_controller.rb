class HomeController < ApplicationController
  def top
    if current_account
      @created_animals = Animal.order(created_at: :desc).limit(5)
    end

  end

  def explanation
  end


end
