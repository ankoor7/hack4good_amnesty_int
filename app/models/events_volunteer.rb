class EventsVolunteer < ActiveRecord::Base
  belongs_to :event
  belongs_to :volunteer, class_name: "User"

  attr_accessor :quantity, :name

end
