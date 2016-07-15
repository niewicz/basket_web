require_relative "../../../lib/model/storage_item"

RSpec.describe Shop::StorageItem do
  context "#initialize" do
    context "#proper arguments" do
      let(:storage_item_init) { Shop::StorageItem.new(1, 10) }

      it "return product_id 1" do
        expect(storage_item_init.product_id).to eql(1)
      end

      it "return quantity 10" do
        expect(storage_item_init.quantity).to eql(10)
      end
    end

    context "#invalid arguments" do
      it "raises argument error if arguments not specified" do
        expect{
          Shop::StorageItem.new()
        }.to raise_error(ArgumentError)
      end

      it "raises argument error if argument is wrong type" do
        expect{
          Shop::StorageItem.new(nil, 2)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
