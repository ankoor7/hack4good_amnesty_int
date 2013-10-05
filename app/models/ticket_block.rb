class TicketBlock < ActiveRecord::Base
  belongs_to :event
  attr_accessible :name, :quantity, :event_id

  validates :event_id, uniqueness: { scope: :name }
  scope :select_quantity, lambda { |event_id| where(event_id: event_id).select("quantity") }

end