class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.date :begin
      t.date :end

      t.belongs_to :customer

      t.timestamps
    end

    create_table :project_goals do |t|
      t.belongs_to :project
      t.belongs_to :goal

      t.timestamps
    end

    create_table :project_observables do |t|
      t.belongs_to :project
      t.belongs_to :observable
      t.boolean :ignored

      t.timestamps
    end
  end
end
