require_relative "../model/storage_item"
require_relative "./fetch_warehouse_item"

module Shop

  class DeleteWarehouseItem
    def call(product_id, quantity)
      warehouse_item = FetchWarehouseItem.new.call(product_id)

      return false unless warehouse_item && warehouse_item.quantity >= quantity

      reduce_quantity(warehouse_item, quantity)
    end

    private
    def reduce_quantity(warehouse_item, quantity)
      if warehouse_item.quantity > quantity
        warehouse_item.quantity -= quantity
      else
        WAREHOUSE.delete(warehouse_item)
      end
      true
    end

  end

end