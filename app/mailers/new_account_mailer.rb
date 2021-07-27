class NewAccountMailer < ApplicationMailer
  default from: "animalndex2020@gmail.com"

  def send_message_to_account(account)
    @account = account
    if @account.ex_temporary_registration
      mail to: @account.email,
          subject: "Freedum Labアカウント登録認証メール" 
    else
      mail to: @account.email,
          subject: "Anima隊員へのアップグレード認証メール" 
    end
    
  end

end
