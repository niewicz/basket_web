require_relative "../services/fetch_basket"
require_relative "../services/fetch_product"

module Shop
  class BasketSummary
    attr_reader :products_list, :sum_net, :sum_gross

    def initialize
      @products_list = []
      create_products_list
      calculate_total_prices
      @sum_net = calculate_sum_net
      @sum_gross = calculate_sum_gross
    end

    private
    def create_products_list
      basket = FetchBasket.new.call
      basket.each do |basket_item|
        product = FetchProduct.new.call(basket_item.product_id)
        quantity = basket_item.quantity
        @products_list << {product: product, quantity: quantity, net: 0, gross: 0}
      end
    end

    def calculate_total_prices
      @products_list.each do |list_item|
        list_item[:net] = list_item[:product].price * list_item[:quantity]
        list_item[:gross] = list_item[:net] * (1 + list_item[:product].vat / 100.0)
      end
    end

    def calculate_sum_net
      @products_list.map{ |list_item| list_item[:net] }.reduce(0, :+)
    end

    def calculate_sum_gross
      @products_list.map{ |list_item| list_item[:gross] }.reduce(0, :+)
    end
  end
end
