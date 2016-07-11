module Shop

  class BasketItem
    attr_reader :product_id
    attr_accessor :quantity

    def initialize(product_id, quantity)
      @product_id = check_id(product_id)
      @quantity = check_quantity(quantity)
    end

    def total_net
      @quantity * get_details.price
    end

    def total_gross
      total_net * (1 + get_details.vat)
    end

    def get_details
      FetchProduct.new.call(@product_id)
    end

    private
    def check_id(id)
      id
    end

    def check_quantity(quantity)
      quantity
    end
  end

end