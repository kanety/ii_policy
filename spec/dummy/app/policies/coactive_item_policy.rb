class CoactiveItemPolicy < IIPolicy::Base
  coact Coactors::APolicy, Coactors::BPolicy

  before_call do
    @context.coactors ||= []
    @context.coactors << 'MAIN'
  end

  def index?
    true
  end

  def show?
    @item.id == 1
  end
end
