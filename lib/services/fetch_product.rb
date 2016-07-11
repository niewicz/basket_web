require_relative "../model/product"

module Shop

  class FetchProduct
    def call(id)
      return unless id
      id = id.to_i
      PORTFOLIO.find do |product|
        product.id == id
      end
    end
  end

end