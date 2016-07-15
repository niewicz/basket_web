require_relative "./fetch_basket"
require_relative "./add_warehouse_item"

module Shop
  class DeleteAllBasketItem
    def call
      basket = FetchBasket.new.call
      basket.each do |basket_item|
        AddWarehouseItem.new.call(basket_item.product_id, basket_item.quantity)
      end
      basket.clear
    end
  end
end
