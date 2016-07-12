require_relative "../model/storage_item"

module Shop

  class FetchWarehouseItem
    def call(product_id)
      return unless product_id
      product_id = product_id.to_i
      WAREHOUSE.find do |warehouse_item|
        warehouse_item.product_id == product_id
      end
    end
  end

end