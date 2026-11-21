class CreateIncidents < ActiveRecord::Migration[8.1]
  def change
    create_table :incidents do |t|
      t.string :serviceId, null: false
      t.string :severity, null: false
      t.string :title, null: false
      t.string :description
      t.string :timestamp
      t.string :dedupKey, null: false
      t.string :status
      t.string :notification_status
      t.string :error
      t.string :callId
      t.string :notification_channel, default: 'Phone'

      t.timestamps
    end

    add_index :incidents, :dedupKey, unique: true
  end
end
