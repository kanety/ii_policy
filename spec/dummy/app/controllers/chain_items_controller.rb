class ChainItemsController < ActionController::Base
  rescue_from IIPolicy::AuthorizationError, with: -> { render plain: 'Not Authorized', status: 403 }

  def index
    @policy = authorize(ChainItemPolicy)
    @items = ChainItem.all
  end

  def show
    @item = ChainItem.find(params[:id])
    @policy = authorize(ChainItemPolicy, item: @item)
  end

  private

  def current_user
    User.find(1)
  end
end
