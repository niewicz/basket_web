require_relative "../model/warehouse_item"

module Shop

  class FetchWarehouseItem
    def call(product_id)
      WAREHOUSE.find do |warehouse_item|
        warehouse_item.product_id == product_id
      end
    end
  end

end