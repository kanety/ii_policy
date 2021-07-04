class Chains::BPolicy < IIPolicy::Base
  before_call do
    @user = @context.user
    @context.chains ||= []
    @context.chains << 'B'
  end

  def index?
    @user.id == 1
  end

  def show?
    @user.id == 1
  end
end
