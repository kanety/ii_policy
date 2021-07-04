class UsersController < ActionController::Base
  rescue_from IIPolicy::AuthorizationError, with: -> { render plain: 'Not Authorized', status: 403 }

  def index
    @policy = authorize(UserPolicy)
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @policy = authorize(UserPolicy, item: @user)
  end

  def export
    @policy = authorize(UserPolicy)

    require 'csv'
    send_data CSV.generate { |csv| User.all.each { |user| csv << [user.id, user.name] } }, filename: 'users.csv'
  end

  private

  def current_user
    User.find(1)
  end
end
