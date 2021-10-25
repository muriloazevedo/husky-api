class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    create_table :invoices, id: :uuid do |t|
      t.string :number, null: false
      t.text :company, null: false
      t.text :billing, null: false
      t.integer :total_amount, null: false
      t.string :email_list, null: false
      t.timestamps
    end
  end
end
