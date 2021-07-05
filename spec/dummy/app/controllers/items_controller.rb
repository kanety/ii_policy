class ItemsController < ActionController::Base
  rescue_from IIPolicy::AuthorizationError, with: -> { render plain: 'Not Authorized', status: 403 }

  def index
    @policy = authorize(ItemPolicy)
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @policy = authorize(ItemPolicy, item: @item)
  end

  def export
    @policy = authorize(ItemPolicy)

    require 'csv'
    send_data CSV.generate { |csv| Item.all.each { |item| csv << [item.id, item.name] } }, filename: 'items.csv'
  end

  private

  def current_user
    User.find(1)
  end
end
