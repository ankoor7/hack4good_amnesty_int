class TicketBlock < ActiveRecord::Base
  belongs_to :event
  has_many :events_volunteers
  has_many :volunteers, through: :events_volunteers
  attr_accessible :name, :quantity, :event_id

  validates :event_id, uniqueness: { scope: :name }
  scope :select_quantity, lambda { |event_id| where(event_id: event_id).select("quantity") }


  def space_available?
    quantity > EventsVolunteer.where(:ticket_block_id => id).count
  end

  def space_left
    quantity - EventsVolunteer.where(:ticket_block_id => id).count
  end

end
