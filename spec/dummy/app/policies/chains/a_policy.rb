class Chains::APolicy < IIPolicy::Base
  before_call do
    @user = @context.user
    @context.chains ||= []
    @context.chains << 'A'
  end

  def index?
    true
  end

  def show?
    true
  end
end
