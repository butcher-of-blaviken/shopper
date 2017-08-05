class Product < ApplicationRecord
  has_many :favourites

  # Returned JSON from LCBO has a lot of extra content we don't use
  ALLOWED_ATTRIBUTES = self.attribute_names.map{ |attr| attr.to_sym }

  def self.cleanup_product_hash(product_hash)
    product_hash.delete_if { |k, _| !ALLOWED_ATTRIBUTES.include?(k) }
    product_hash
  end

  def get_price_in_dollars
    price_in_cents.to_f / 100
  end

  def alcohol_content_in_percent
    alcohol_content.to_f / 100
  end

  def self.bulk_add_if_necessary(products)
    products = products.map{ |product| cleanup_product_hash(product) }
    product_ids = products.map{ |product| product[:id] }
    existing_records = Product.where(id: product_ids).collect(&:id)
    remaining = product_ids - existing_records
    products = products.select{ |product| remaining.include?(product[:id]) }
    products.each do |product|
      p = Product.new(product)
      p.save!
    end
  end
end