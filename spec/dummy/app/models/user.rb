class User
  include ActiveModel::Model

  attr_accessor :id, :name

  def admin?
    @id == 1
  end

  class << self
    def find(id)
      id = id.to_i
      new(id: id, name: "user#{id}")
    end
  end
end
