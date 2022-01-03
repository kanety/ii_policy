class Callbacks::AroundCallPolicy < ItemPolicy
  around_call do |policy, block|
    @callback = 'around'
    block.call
  end
end
