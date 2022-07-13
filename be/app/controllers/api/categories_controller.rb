module Api
  class CategoriesController < ::ApplicationController
    before_action :authorized
    def index
      categories = Category.all
      render json: ::Dto::BaseResponse.ok(
        data: {
          categories: categories,
        }
      )
    end
  end
end