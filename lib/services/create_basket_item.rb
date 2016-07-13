require_relative "../model/storage_item"
require_relative "./fetch_basket_item"
require_relative "./delete_warehouse_item"

module Shop
  class CreateBasketItem
    def initialize(params)
      @product_id = params.fetch("product_id").to_i
      @quantity = params.fetch("quantity").to_i
    end

    def call
      return unless DeleteWarehouseItem.new.call(@product_id, @quantity) == true
      basket_item = FetchBasketItem.new.call(@product_id)

      if basket_item
        basket_item.quantity += @quantity
      else
        BASKET << StorageItem.new(@product_id, @quantity)
      end
    end
  end
end
