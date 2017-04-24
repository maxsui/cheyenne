class CreateSessionUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    User.update_all "name = email"

    create_table :session_users do |t|
      t.belongs_to :session
      t.belongs_to :user

      t.timestamps
    end
  end
end
