require_relative "../../../lib/model/product"

RSpec.describe Shop::Product do
  context "#initialize" do
    context "#proper arguments" do
      let(:product_init) { Shop::Product.new("Gone Girl", 19.40, 0.08, "Gillian Flynn", "gone_girl.jpg") }

      it "returns title Gone Girl" do
        expect(product_init.title).to eql("Gone Girl")
      end

      it "returns author Gone Girl" do
        expect(product_init.author).to eql("Gillian Flynn")
      end

      it "returns img filename gone_girl.jpg" do
        expect(product_init.img_address).to eql("gone_girl.jpg")
      end

      it "returns price 19.40" do
        expect(product_init.price).to eql(19.40)
      end

      it "returns vat 0.08" do
        expect(product_init.vat).to eql(0.08)
      end
    end

    context "#invalid arguments" do
      it "raises argument error if arguments not specified" do
        expect{
          Shop::Product.new()
        }.to raise_error(ArgumentError)
      end

      it "raises argument error if argument is wrong type" do
        expect{
          Shop::Product.new(1, 1, 1, "a", "a")
        }.to raise_error(ArgumentError)
      end
    end
  end
end
