class Item
  include ActiveModel::Model

  attr_accessor :id, :name, :status

  class << self
    def all
      (1..10).to_a.map { |i| new(id: i, name: "item#{i}", status: 'public') }
    end

    def find(id)
      id = id.to_i
      new(id: id, name: "item#{id}", status: 'public')
    end
  end
end
