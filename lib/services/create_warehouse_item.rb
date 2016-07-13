require_relative "../model/storage_item"
require_relative "./fetch_warehouse_item"

module Shop
  class CreateWarehouseItem
    def call(product_id, quantity)
      warehouse_item = FetchWarehouseItem.new.call(product_id)

      if warehouse_item
        warehouse_item.quantity += quantity
      else
        WAREHOUSE << StorageItem.new(product_id, quantity)
      end
    end
  end
end
