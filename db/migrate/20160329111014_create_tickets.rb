class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :ticket_type, index: true, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps null: false
    end
  end
end
