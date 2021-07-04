class Callbacks::BeforePolicy < UserPolicy
  before_call do
    @callback = 'before'
  end
end
