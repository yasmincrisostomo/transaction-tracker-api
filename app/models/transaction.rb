class Transaction < ApplicationRecord
  belongs_to :product

  def self.upload_transactions_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      product = Product.find_by(name: row["name"], price: row["price"])
      Transaction.create(product_id: product.id, quantity: row["quantity"], date: row["date"])
    end
  end
end
