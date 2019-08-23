class User < ApplicationRecord
    validates :email, presence: true
    validates :username, presence: true
    has_many :events
    has_many :event_attendees
    has_many :attended_events, through: :event_attendees, :source => :event
    has_many :requested, -> { where('status = ?', 'requested', ) }, through: :event_attendees, :source => :event
    has_many :invited, -> { where('status = ?', 'invited') }, through: :event_attendees, :source => :event
    has_many :accepted, -> { where('status = ?', 'accepted') }, through: :event_attendees, :source => :event
end
