# Talks are the Uber record for everything about a talk
class CreateTalks < ActiveRecord::Migration[5.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :talks do |t|
      t.integer :conference_day
      t.time    :start_time
      t.time    :end_time
      t.integer :program_session_id
      t.string  :title
      t.string  :presenter
      t.string  :room
      t.string  :track
      t.text    :description
      t.timestamps
    end
  end
end
