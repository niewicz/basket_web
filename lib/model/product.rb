module Shop
  class Product
    attr_reader :id, :title, :price, :vat, :author, :img_address
    @@id = 0

    def initialize(title, price, vat, author, img_address)
      @title = check_string(title)
      @price = check_float_positive(price)
      @vat = check_float_positive(vat * 1.0)
      @author = check_string(author)
      @img_address = check_string(img_address)
      @id = set_id
    end

    private
    def set_id
      @@id += 1
    end

    def check_string(var_to_check)
      raise ArgumentError unless var_to_check.is_a?(String)
      var_to_check
    end

    def check_float_positive(var_to_check)
      raise ArgumentError if !var_to_check.is_a?(Float) || var_to_check <= 0
      var_to_check
    end
  end
end
