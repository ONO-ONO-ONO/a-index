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
end
