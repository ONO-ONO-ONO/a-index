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

  # 仮登録アカウントは他画面に遷移できないようにする & 一般会員をアップグレードする際に認証コードを発行してから2時間(7200秒)が経過した場合は仮メールアドレスを消去する。
  def ex_temporary_registration
    if account_signed_in?
      if current_account.ex_temporary_registration
        redirect_to ex_good_luck_path, alert: '認証コードを入力してください'
      end
    end

    # 認証コードを発行してから2時間(7200秒)が経過した場合は仮作成アカウントを消去する。
    if account_signed_in?
      if current_account.random_timepass.present? && (current_account.updated_at + 7200 <= Time.now)
        current_account.update(email: "", random_timepass: "")
        redirect_to root_path, alert: '認証コードを発行してから2時間が経過した為、仮メールアドレス情報を削除しました'
      end
    end
  end
end
