class AddIndexToJoinTable < ActiveRecord::Migration[5.2]
  def change
    add_index :event_attendees, [:event_id, :user_id], :unique => true
  end
end
