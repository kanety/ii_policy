class Coactors::APolicy < ApplicationPolicy
  context :called, default: []

  before_call do
    @context.called << 'A'
  end

  def index?
    true
  end

  def show?
    true
  end
end
