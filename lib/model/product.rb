module Shop
  class Product
    attr_reader :id, :name, :price, :vat
    @@id = 0

    def initialize(name, price, vat)
      @name = check_name(name)
      @price = check_price(price)
      @vat = check_vat(vat)
      @id = set_id
    end

    private
    def set_id
      @@id += 1
    end

    def check_name(name)
      name
    end

    def check_price(price)
      price
    end

    def check_vat(vat)
      vat
    end
  end
end
