class RemoveNumberVolunteersFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :number_volunteers
  end

  def down
    add_column :events, :number_volunteers, :integer
  end
end
