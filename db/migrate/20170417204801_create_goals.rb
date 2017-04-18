class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goal_categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :goals do |t|
      t.string :name
      t.belongs_to :goal_category
      t.timestamps
    end
  end
end
