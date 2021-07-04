class Callbacks::AroundPolicy < UserPolicy
  around_call do |policy, block|
    @callback = 'around'
    block.call
  end
end
