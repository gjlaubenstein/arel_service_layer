class ProductsService
  def self.get_product_by(repo: ProductsRepository.new, name:)
    repo.find_by(column: :name, value: name)
  end

  def self.all_products(repo: ProductsRepository.new)
    repo.find_all
  end

  def self.create(repo: ProductsRepository.new, params:)
    product = Product.new(params)
    repo.insert(product)
  end

  private
  attr_reader :repo
end
