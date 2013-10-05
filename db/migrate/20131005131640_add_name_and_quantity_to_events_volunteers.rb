class AddNameAndQuantityToEventsVolunteers < ActiveRecord::Migration
  def change
    add_column :events_volunteers, :name, :string
    add_column :events_volunteers, :quantity, :integer
  end
end
