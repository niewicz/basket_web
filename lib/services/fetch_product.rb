require_relative "../model/product"

module Shop

  class FetchProduct
    def call(id)
      PORTFOLIO.find do |product|
        product.id == id
      end
    end
  end

end