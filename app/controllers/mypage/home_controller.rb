class Mypage::HomeController < ApplicationController
  # ログインしていない状態でアクセスされたら、ログイン画面に誘導する
  before_action :authenticate_user!, only: :index

  def index; end
end
