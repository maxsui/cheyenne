class CreateObservables < ActiveRecord::Migration[5.1]
  def change
    create_table :observables do |t|
      t.string :name
      t.timestamps
    end

    create_table :goals_observables do |t|
      t.belongs_to :goal
      t.belongs_to :observable
      t.timestamps
    end
  end
end
