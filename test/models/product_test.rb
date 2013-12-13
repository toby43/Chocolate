require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product is not valid without a unique title" do
    product = Product.new(title: products(:lindt).title,
                          description: "Good chocolate",
                          price: 1.34,
                          image_url: "lindt.jpg")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do 
    product = Product.new(title: "chocolate bar",
                          description: "cocoa desc",
                          image_url: "sample.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
          product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
          product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "chocolate bar",
                description: "cocoa desc",
                image_url: image_url,
                price: 1)
  end

  test "test image url" do
    ok =  %w{a.png b.jpg c.gif d.JPG}
    bad = %w{a.sd b.pdf c.ggg}
    ok.each do |name|
      assert new_product(name).valid? , "#{name} should be valid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end
end

