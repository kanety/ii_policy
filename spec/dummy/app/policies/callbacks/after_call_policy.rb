class Callbacks::AfterCallPolicy < ItemPolicy
  after_call do
    @callback = 'after'
  end
end
