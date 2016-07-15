require_relative "../model/storage_item"
require_relative "./fetch_basket_item"
require_relative "./add_warehouse_item"

module Shop
  class DeleteBasketItem
    def initialize(params)
      @product_id = params.fetch("product_id").to_i
      @quantity = params.fetch("quantity").to_i
    end

    def call
      basket_item = FetchBasketItem.new.call(@product_id)

      return unless basket_item && basket_item.quantity >= @quantity

      reduce_quantity(basket_item)
      return_to_basket
    end

    private
    def reduce_quantity(basket_item)
      if basket_item.quantity > @quantity
        basket_item.quantity -= @quantity
      else
        BASKET.delete(basket_item)
      end
    end

    def return_to_basket
      AddWarehouseItem.new.call(@product_id, @quantity)
    end
  end
end
