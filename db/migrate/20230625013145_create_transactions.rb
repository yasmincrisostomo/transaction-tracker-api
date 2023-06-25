class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.date :date

      t.timestamps
    end
  end
end
