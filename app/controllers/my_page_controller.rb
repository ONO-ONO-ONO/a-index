class MyPageController < ApplicationController
  before_action :ex_temporary_registration

  def index
    @account = current_account
  end

  def edit
    @account = current_account
    @account_role = Role.find_by(role_id: @account.role)
    @account_images = AccountImage.where(account_id: @account.id)

    @role = Role.pluck(:role_name)
  end

  def email_edit
  end

  def update
    @account = current_account

    #選択肢の項目に合ったrole_idを取得する
    role = Role.find_by(role_name: params[:account][:role])
    params[:account][:role] = role.role_id

    if @account.update(account_params)
      redirect_to my_page_path, notice: '更新しました'
    else
      render :edit
    end
  end

  def account_image_upload
  end

  def remove_image
  end

  private
  def account_params
    params.require(:account).permit(:id,
                                    :account_name,
                                    :email,
                                    :role
                                    )
  end

end
