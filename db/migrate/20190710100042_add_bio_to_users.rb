class AddBioToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, :string, after: :name
  end
end
