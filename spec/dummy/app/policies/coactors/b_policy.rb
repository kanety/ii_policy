class Coactors::BPolicy < ApplicationPolicy
  context :called, default: []

  before_call do
    @context.called << 'B'
  end

  def index?
    @user.admin?
  end

  def show?
    @user.admin?
  end
end
