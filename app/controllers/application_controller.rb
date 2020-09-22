class ApplicationController < ActionController::Base

  def set_redlist
    @redlist_guide = ""
    @redlists = Redlist.all
    @redlists.each do |redlist|
      @redlist_guide.concat("#{redlist.red_list_name}：#{redlist.red_list_details}<br>")
    end
  end

  private
  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  # 仮登録アカウントは他画面に遷移できないようにする
  def ex_temporary_registration
    if account_signed_in?
      if current_account.ex_temporary_registration
        redirect_to ex_good_luck_path, alert: '認証コードを入力してください'
      end
    end
  end
  
end
