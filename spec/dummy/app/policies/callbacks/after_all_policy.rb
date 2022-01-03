class Callbacks::AfterAllPolicy < ItemPolicy
  after_all do
    @callback = 'after'
  end
end
