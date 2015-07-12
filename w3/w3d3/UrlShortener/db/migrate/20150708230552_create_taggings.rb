class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :shortened_url_id
      t.integer :topic_id
    end
    add_index :taggings, :shortened_url_id
    add_index :taggings, :topic_id
  end
end
