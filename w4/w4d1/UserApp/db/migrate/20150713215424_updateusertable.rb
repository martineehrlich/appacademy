class Updateusertable < ActiveRecord::Migration
  def change
      remove_column(:users, :name, :string, {null: false})
      remove_column(:users, :email, :string, {null: false})
      add_column(:users, :username, :string)
  end
end
