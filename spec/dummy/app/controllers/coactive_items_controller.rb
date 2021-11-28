class CoactiveItemsController < ActionController::Base
  rescue_from IIPolicy::AuthorizationError, with: -> { render plain: 'Not Authorized', status: 403 }

  def index
    @policy = authorize(CoactiveItemPolicy)
    @items = CoactiveItem.all
  end

  def show
    @item = CoactiveItem.find(params[:id])
    @policy = authorize(CoactiveItemPolicy, item: @item)
  end

  private

  def current_user
    User.find(1)
  end
end
