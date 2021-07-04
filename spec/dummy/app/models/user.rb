class User
  include ActiveModel::Model

  attr_accessor :id, :name

  def admin?
    @id == 1
  end

  class << self
    def all
      (1..10).to_a.map { |i| new(id: i, name: "user#{i}") }
    end

    def find(id)
      id = id.to_i
      new(id: id, name: "user#{id}")
    end
  end
end
