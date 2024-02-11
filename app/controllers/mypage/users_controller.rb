class Mypage::UsersController < ApplicationController
  # ログインしていない状態でアクセスされたら、ログイン画面に誘導する
  before_action :authenticate_user!
  before_action :only_my_page_can_be_accessible!

  def show
    @conference = @user.conference
    @conferences = Conference.all.map(&:name) if @conference.nil?
    @participations = Participation.where(user: @user).where(conference: @conference).includes(:slot).order("slots.start_time")
  end

  def edit
    @conference = current_user&.conference
    if @conference.nil?
      flash[:alert] = "まずイベントを登録してください"
      redirect_to mypage_user_path(current_user)
    else
      @slots = @conference.days.map { |d| d.tracks.map(&:slots) }.flatten.sort_by { |s| [s.start_time, s.track.seq_no] }
    end
  end

  def update
    p = user_params
    if p.nil?
      p = params[:sessions] - ["-1"]
      u = current_user
      c = u.conference
      Participation.where(conference: c).where(user: u).map(&:delete)
      p.each do |sid|
        Participation.create(user: u, slot: Slot.find(sid), conference: c)
      end
      flash[:notice] = "参加予定のセッションを変更しました。"
    else
      current_user.conference = Conference.find_by(name: p[:conference])
      current_user.save
    end
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
    params.require(:user).permit(:conference) if params.include?("user")
  end
end
