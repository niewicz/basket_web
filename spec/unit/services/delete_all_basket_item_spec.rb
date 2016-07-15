require_relative "../../../lib/services/delete_all_basket_item"
require_relative "../../../lib/services/fetch_basket"
require_relative "../../../lib/services/add_basket_item"

RSpec.describe Shop::DeleteAllBasketItem do
  it "clears basket" do
    Shop::AddBasketItem.new({ "product_id" => "1", "quantity" => "3" }).call
    Shop::DeleteAllBasketItem.new.call

    expect(Shop::FetchBasket.new.call).to be_empty
  end
end
