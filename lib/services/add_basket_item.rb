require_relative "../model/storage_item"
require_relative "./fetch_basket_item"
require_relative "./delete_warehouse_item"

module Shop
  class AddBasketItem
    def initialize(params)
      @quantity = params.fetch("quantity").to_i
      @product_id = check_id(params.fetch("product_id").to_i)
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

    private
    def check_id(id)
      raise ArgumentError unless id > 0
      id
    end
  end
end
