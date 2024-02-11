class ParticipationsController < ApplicationController
  def create
    p = participation_params
    user = User.find(p[:uid])
    slot = Slot.find(p[:sid])
    conf = slot.track.day.conference
    Participation.create(user: user, slot: slot, conference: conf)
    user.conference = conf
    user.save
    flash[:notice] = "「#{slot.title}」を登録しました"
    redirect_to mypage_user_path(user)
  end

  def destroy
    part = Participation.find(params[:id])
    user = part.user
    part.delete
    flash[:notice] = "「#{part.slot.title}」の登録は削除されました"
    redirect_to mypage_user_path(user)
  end

  private

  def participation_params
    params.require(:participation).permit(:uid, :sid)
  end
end
