class Callbacks::BeforePolicy < ItemPolicy
  before_call do
    @callback = 'before'
  end
end
