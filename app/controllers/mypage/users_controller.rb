class Mypage::UsersController < ApplicationController
  # ログインしていない状態でアクセスされたら、ログイン画面に誘導する
  before_action :authenticate_user!
  before_action :only_my_page_can_be_accessible!

  def show; end

  def edit; end

  def update; end

  private

  # 他人のマイページにはアクセスできないように
  def only_my_page_can_be_accessible!
    @user = User.find(params[:id])
    # マイページの所持者とログインユーザが異なれば、マイページへリダイレクトさせる
    redirect_to mypage_user_path(current_user) if @user != current_user
  end
end
