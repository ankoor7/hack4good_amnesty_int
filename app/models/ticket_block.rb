class TicketBlock < ActiveRecord::Base
  belongs_to :event
  attr_accessible :name, :quantity, :event_id

  validates :event_id, uniqueness: { scope: :name }
end
