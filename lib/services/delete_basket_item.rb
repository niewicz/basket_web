require_relative "../model/storage_item"
require_relative "./fetch_basket_item"
require_relative "./create_warehouse_item"

module Shop

  class DeleteBasketItem
    def call(product_id, quantity)
      basket_item = FetchBasketItem.new.call(product_id)

      return unless basket_item && basket_item.quantity >= quantity

      reduce_quantity(basket_item, quantity)
      return_to_basket(product_id, quantity)
    end

    private
    def reduce_quantity(basket_item, quantity)
      if basket_item.quantity > quantity
        basket_item.quantity -= quantity
      else
        BASKET.delete(basket_item)
      end
    end

    def return_to_basket(product_id, quantity)
      CreateWarehouseItem.new.call(product_id, quantity)
    end

  end

end