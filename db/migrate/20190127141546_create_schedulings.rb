class CreateSchedulings < ActiveRecord::Migration[5.1]
  def change
    create_table :schedulings do |t|
      t.datetime :end_date
      t.integer :repeat
    end

    change_table :seances do |t|
      t.references :scheduling
    end
  end
end
