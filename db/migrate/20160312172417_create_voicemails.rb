class CreateVoicemails < ActiveRecord::Migration
  def change
    create_table :voicemails do |t|
      t.belongs_to :call, index: true, foreign_key: true
      t.string :url
      t.integer :duration
    end

    add_column :calls, :voicemail_id, :integer
    add_index :calls, :voicemail_id
  end
end
