class Product
  attr_reader :name, :part_number

  def initialize(data)
    @name = data["name"]
    @part_number = data["part_number"]
  end
end
