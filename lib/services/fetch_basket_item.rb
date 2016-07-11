module Shop

  class FetchBasketItem
    def call(product_id)
      BASKET.find do |basket_item|
        basket_item.product_id == product_id
      end
    end
  end

end