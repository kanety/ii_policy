class Coactors::BPolicy < IIPolicy::Base
  before_call do
    @user = @context.user
    @context.coactors ||= []
    @context.coactors << 'B'
  end

  def index?
    @user.admin?
  end

  def show?
    @user.admin?
  end
end
