class Callbacks::AroundAllPolicy < ItemPolicy
  around_all do |policy, block|
    @callback = 'around'
    block.call
  end
end
