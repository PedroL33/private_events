class AddStatusToEventAttendees < ActiveRecord::Migration[5.2]
  def change
    add_column :event_attendees, :status, :string
  end
end
