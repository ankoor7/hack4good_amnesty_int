class Event < ActiveRecord::Base
  attr_accessible :date, :description, :location, :name, :special_instructions, :latitude, :longitude, :causes, :cause_list, :image, :cause_search_hack, :ticket_blocks_attributes



  # ASSOCIATIONS
  has_many :events_volunteers  # Moved the dependency removal to the
                                                 # Event Observer:
                                                 #     - before_destroy callback ", dependent: :destroy"
  has_many :ticket_blocks
  accepts_nested_attributes_for :ticket_blocks, allow_destroy: true
  has_many :volunteers, through: :events_volunteers
  belongs_to :group

  # CAUSES USING ACTS-AS-TAGGABLE-ON GEM
  acts_as_taggable_on :causes

  # GEOCODER SETTINGS
  geocoded_by :location
  after_validation :geocode

  # gmaps4rails setting
  acts_as_gmappable

  # Image uploader
  mount_uploader :image, ImageUploader

  # VALIDATIONS
  validates :date, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :name, presence: true


default_scope :order => 'date'
scope :by_date, -> { order('date').where(date: DateTime.now..DateTime.now+2.month) }
scope :available_events, lambda { |user| where("id NOT IN (?)", user.event_ids).where(date: DateTime.now..DateTime.now+1.month) }
scope :approaching_events, lambda { where(date: DateTime.now+2.days..DateTime.now+3.days) }
scope :approaching_events_email_not_sent, lambda { where(welcome_email_sent: false) }
scope :with_tickets, -> { includes(:ticket_blocks) }

  def gmaps4rails_address
    "#{self.location}"
  end

  def number_volunteers
    events_volunteer_ids.length
  end

  def space_available?
    volunteers.count < total_number_of_tickets
  end

  def total_number_of_tickets
    ticket_blocks.select_quantity(id).inject(0) {|sum, ticket| sum + ticket.quantity }
  end

  def remaining_spaces
    total_number_of_tickets - volunteers.count
  end

  def health
    volunteers.count / total_number_of_tickets unless total_number_of_tickets == 0
  end

  def days_till_event
    ((Time.zone.now - date) /1.day ).to_i
  end


end
