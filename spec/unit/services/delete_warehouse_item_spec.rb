require_relative "../../../lib/services/fetch_warehouse_item"
require_relative "../../../lib/model/storage_item"
require_relative "../../../lib/services/delete_warehouse_item"
require_relative "../../../lib/services/add_warehouse_item"

RSpec.describe Shop::DeleteWarehouseItem do
  let(:fetch_warehouse_item) { Shop::FetchWarehouseItem.new }
  let(:product_id) { 3 }
  let(:count) { fetch_warehouse_item.call(product_id).quantity }

  it "changes quantity of an item" do
    modify_warehouse(product_id, count - 1)

    expect(fetch_warehouse_item.call(product_id).quantity).to eql(1)

    restore_warehouse(product_id, count - 1)
  end

  it "deletes an item" do
    modify_warehouse(product_id, count)

    expect(fetch_warehouse_item.call(product_id)).to be nil

    restore_warehouse(product_id, count)
  end

  def modify_warehouse(id, quantity)
    Shop::DeleteWarehouseItem.new.call(id, quantity)
  end

  def restore_warehouse(id, quantity)
    Shop::AddWarehouseItem.new.call(id, quantity)
  end
end
