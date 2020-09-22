class NewAccountMailer < ApplicationMailer
  default from: "animalndex2020@gmail.com"

  def send_message_to_account(account)
    @account = account
    mail to: @account.email,
         subject: "AnimaIndexアカウント登録認証メール"    
  end

end
