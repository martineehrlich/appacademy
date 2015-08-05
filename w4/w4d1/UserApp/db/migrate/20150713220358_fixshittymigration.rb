class Fixshittymigration < ActiveRecord::Migration
  def change
    change_column(:users, :username, :string, {presence: true})
    add_index(:users, :username, {unique: true})
  end
end
