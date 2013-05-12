class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :phone_number
      t.string :address
      t.text :info
      t.string :who_updated

      t.timestamps
    end

    add_index :customers, :first_name
    add_index :customers, :last_name
    add_index :customers, :middle_name
  end
end
