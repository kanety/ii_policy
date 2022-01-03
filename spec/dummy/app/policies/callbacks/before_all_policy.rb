class Callbacks::BeforeAllPolicy < ItemPolicy
  before_all do
    @callback = 'before'
  end
end
