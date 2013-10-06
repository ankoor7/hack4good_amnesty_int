class AddTicketBlockToEventsVolunteer < ActiveRecord::Migration
  def change
    add_column :events_volunteers, :ticket_block_id, :integer
    add_index :events_volunteers, :ticket_block_id
  end
end
