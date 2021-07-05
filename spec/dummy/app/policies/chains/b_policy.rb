class Chains::BPolicy < IIPolicy::Base
  before_call do
    @user = @context.user
    @context.chains ||= []
    @context.chains << 'B'
  end

  def index?
    @user.admin?
  end

  def show?
    @user.admin?
  end
end
