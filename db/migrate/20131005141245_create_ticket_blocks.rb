class CreateTicketBlocks < ActiveRecord::Migration
  def change
    create_table :ticket_blocks do |t|
      t.string :name
      t.integer :quantity
      t.references :event

      t.timestamps
    end
    add_index :ticket_blocks, :event_id
  end
end
