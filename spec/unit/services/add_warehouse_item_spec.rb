require_relative "../../../lib/services/fetch_warehouse_item"
require_relative "../../../lib/model/storage_item"
require_relative "../../../lib/services/add_warehouse_item"
require_relative "../../../lib/services/delete_warehouse_item"

RSpec.describe Shop::AddWarehouseItem do
  let(:fetch_warehouse_item) { Shop::FetchWarehouseItem.new }
  let(:product_id) { 6 }
  let(:count) { 3 }

  it "creates new item in warehouse if not included" do
    modify_warehouse(product_id, count)

    expect(fetch_warehouse_item.call(product_id).quantity).to eql(count)

    restore_warehouse(product_id, count)
  end

    def restore_warehouse(id, quantity)
    Shop::DeleteWarehouseItem.new.call(id, quantity)
  end

  def modify_warehouse(id, quantity)
    Shop::AddWarehouseItem.new.call(id, quantity)
  end
end
