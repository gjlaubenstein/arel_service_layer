class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    product = ProductsService
      .get_product_by(name: params[:name])

    render json: product
  end

  def index
    render json: ProductsService.all_products
  end

  def create
    ProductsService.create(params: params)

    head :created
  end
end
