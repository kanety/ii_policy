class CoactiveItemPolicy < ApplicationPolicy
  coact Coactors::APolicy, Coactors::BPolicy

  context :called, default: []

  before_call do
    @context.called << 'MAIN'
  end

  def index?
    true
  end

  def show?
    @item.id == 1
  end
end
