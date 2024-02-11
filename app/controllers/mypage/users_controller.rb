class Mypage::UsersController < ApplicationController
  # ログインしていない状態でアクセスされたら、ログイン画面に誘導する
  before_action :authenticate_user!
  before_action :only_my_page_can_be_accessible!

  def show
    @conference = @user.conference
    @conferences = Conference.all.map(&:name) if @conference.nil?
  end

  def edit; end

  def update
    p = user_params
    current_user.conference = Conference.find_by(name: p[:conference])
    current_user.save
    redirect_to mypage_user_path(current_user)
  end

  private

  # 他人のマイページにはアクセスできないように
  def only_my_page_can_be_accessible!
    @user = User.find(params[:id])
    # マイページの所持者とログインユーザが異なれば、マイページへリダイレクトさせる
    redirect_to mypage_user_path(current_user) if @user != current_user
  end

  def user_params
    params.require(:user).permit(:conference)
  end
end
