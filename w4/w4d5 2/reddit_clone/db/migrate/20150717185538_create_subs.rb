class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :user
      t.timestamps null: false
    end
  end
end
