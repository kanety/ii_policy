class Callbacks::BeforeCallPolicy < ItemPolicy
  before_call do
    @callback = 'before'
  end
end
