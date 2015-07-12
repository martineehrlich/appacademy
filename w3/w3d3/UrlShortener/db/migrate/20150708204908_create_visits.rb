class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :shortened_url_id, :submitter_id
      t.timestamps null: false
    end

    add_index :visits, :shortened_url_id
    add_index :visits, :submitter_id
  end
end
