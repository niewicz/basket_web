require_relative "../model/basket_item"
require_relative "./fetch_basket_item"
require_relative "./delete_warehouse_item"

module Shop

  class CreateBasketItem
    def call(product_id, quantity)
      return unless DeleteWarehouseItem.new.call(product_id, quantity) == true
      basket_item = FetchBasketItem.new.call(product_id)

      if basket_item
        basket_item.quantity += quantity
      else
        BASKET << BasketItem.new(product_id, quantity)
      end
    end
  end

end