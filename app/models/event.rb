class Event < ApplicationRecord
    belongs_to :creator, :class_name => 'User', :foreign_key => "user_id"
    has_many :event_attendees
    has_many :attendees, :through => :event_attendees, :source => :user
    has_many :requested, -> { where('status = ?', 'requested') }, through: :event_attendees, :source => :user
    has_many :invited, -> { where('status = ?', 'invited') }, through: :event_attendees, :source => :user
    has_many :accepted, -> { where('status = ?', 'accepted') }, through: :event_attendees, :source => :user
    validates :title, presence: true
    validates :date, presence: true
    scope :past, -> { select("*").group("date").having("date < ?", Time.now) }
    scope :upcoming, -> { select("*").group("date").having("date > ?", Time.now) }
end
