class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.string :number, null: false
      t.text :company, null: false
      t.text :billing, null: false
      t.money :total_amount, null: false
      t.string :email_list, null: false
      t.timestamps
    end
  end
end
