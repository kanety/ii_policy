class ChainItemPolicy < IIPolicy::Base
  include IIPolicy::Chain

  chain Chains::APolicy, Chains::BPolicy

  before_call do
    @context.chains ||= []
    @context.chains << 'MAIN'
  end

  def index?
    true
  end

  def show?
    @item.id == 1
  end
end
