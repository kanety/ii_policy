class Callbacks::AfterPolicy < UserPolicy
  after_call do
    @callback = 'after'
  end
end
