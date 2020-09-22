class ExController < ApplicationController
  before_action :ex_temporary_registration, only: [:ex_sign_in]

  require 'securerandom'

  def ex_sign_in
    @account = Account.new
  end

  def ex_create
    @account = Account.new(ex_params)
    if @account.save
      # sign_in @account
      @account.ex_temporary_registration = true
      @account.random_timepass = SecureRandom.base64(3)
      @account.save
      NewAccountMailer.send_message_to_account(@account).deliver_now
      sign_in @account
      redirect_to ex_good_luck_path
    else
      render 'ex_sign_in'
    end
  end

  def good_luck
    @account = Account.find_by(id: current_account.id)

    # 認証コードを発行してから2時間(7200秒)が経過した場合は仮作成アカウントを消去する。
    if @account.created_at + 7200 <= Time.now
      @account.destroy
      redirect_to root_path, alert: '認証コードを発行してから2時間が経過した為、仮作成したアカウントを削除しました'

    end
  end

  def on_timepass
    @account = Account.find_by(email: ex_params["email"])

    if @account.random_timepass == ex_params["random_timepass"]
      @account.update(role: 50, ex_temporary_registration: false, random_timepass: "")
      # sign_in @account
      redirect_to root_path, notice: '作成しました。AnimaIndexにようこそ！'
    else
      @error_message = "認証コードが異なります"
      render 'good_luck'
    end


  end

  private
  def ex_params
    params.require(:accounts).permit(:email,
                                     :account_name,
                                     :password,
                                     :password_confirmation,
                                     :ex_status,
                                     :random_timepass
                                    )
  end


end
