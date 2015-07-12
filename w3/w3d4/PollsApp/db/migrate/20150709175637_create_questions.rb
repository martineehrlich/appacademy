class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :poll_id
      t.text :text
      t.timestamps null: false
    end

    add_index :questions, :poll_id
  end
end
