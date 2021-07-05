class Callbacks::AfterPolicy < ItemPolicy
  after_call do
    @callback = 'after'
  end
end
