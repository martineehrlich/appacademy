class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.references :post, index: true, foreign_key: true
      t.references :sub, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
