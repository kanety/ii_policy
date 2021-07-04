class ChainUsersController < ActionController::Base
  rescue_from IIPolicy::AuthorizationError, with: -> { render plain: 'Not Authorized', status: 403 }

  def index
    @policy = authorize(ChainUserPolicy)
    @users = ChainUser.all
  end

  def show
    @user = ChainUser.find(params[:id])
    @policy = authorize(ChainUserPolicy, item: @user)
  end

  private

  def current_user
    User.find(1)
  end
end
