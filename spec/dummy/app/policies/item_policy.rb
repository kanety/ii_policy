class ItemPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    @item.id == 1
  end

  def export?
    rand(2) == 1
  end
end
