class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.datetime :begin
      t.datetime :end

      t.timestamps
    end

    create_table :session_customers do |t|
      t.belongs_to :session
      t.belongs_to :customer

      t.timestamps
    end
  end
end
