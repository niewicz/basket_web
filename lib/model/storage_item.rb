module Shop
  class StorageItem
    attr_reader :product_id
    attr_accessor :quantity

    def initialize(product_id, quantity)
      @product_id = check_positive_numeric(product_id)
      @quantity = check_positive_numeric(quantity)
    end

    private
    def check_positive_numeric(var_to_check)
      raise ArgumentError unless var_to_check.is_a?(Integer) && var_to_check > 0
      var_to_check
    end
  end
end
