require_relative "../services/fetch_basket"
require_relative "../services/fetch_product"

module Shop

  class BasketSummary
    attr_reader :products_list, :sum_net, :sum_gross

    def initialize
      @products_list= []
      create_products_list
      calculate_totals
      @sum_net = calc_sum_net
      @sum_gross = calc_sum_gross
    end

    private
    def create_products_list
      basket = FetchBasket.new.call
      basket.each do |basket_item|
        @products_list << {product: FetchProduct.new.call(basket_item.product_id), quantity: basket_item.quantity, total_net: 0, total_gross: 0}
      end
    end

    def calculate_totals
      @products_list.each do |list_item|
        list_item[:total_net] = list_item[:product].price * list_item[:quantity]
        list_item[:total_gross] = list_item[:total_net] * (1 + list_item[:product].vat)
      end
    end

    def calc_sum_net
      @products_list.map{ |list_item| list_item[:total_net] }.reduce(:+)
    end

    def calc_sum_gross
      @products_list.map{ |list_item| list_item[:total_gross] }.reduce(:+)
    end
  end

end