module Shop
  class FetchBasketItem
    def call(product_id)
      return unless product_id
      product_id = product_id.to_i
      BASKET.find do |basket_item|
        basket_item.product_id == product_id
      end
    end
  end
end
