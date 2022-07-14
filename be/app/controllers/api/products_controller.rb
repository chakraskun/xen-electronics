module Api
  class ProductsController < ::ApplicationController
    before_action :authorized

    def index
      products = Product.all
      if params[:category_id].present?
        products = products.where(category_id: params[:category_id])
      end
      render json: ::Dto::BaseResponse.ok(
        data: {
          products: products.as_json(include: :category),
        }
      )
    end
  end
end