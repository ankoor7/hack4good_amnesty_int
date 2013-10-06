class EventsVolunteer < ActiveRecord::Base
  belongs_to :event
  belongs_to :volunteer, class_name: "User"
  belongs_to :ticket_block

  attr_accessible :event_id, :ticket_block_id, :volunteer_id

end
