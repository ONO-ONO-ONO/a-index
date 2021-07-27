class AnimaindexTopController < ApplicationController

  def index
    if current_account
      @created_animals = Animal.order(created_at: :desc).limit(5)
    end
  end

end