class Coactors::APolicy < IIPolicy::Base
  before_call do
    @user = @context.user
    @context.coactors ||= []
    @context.coactors << 'A'
  end

  def index?
    true
  end

  def show?
    true
  end
end
