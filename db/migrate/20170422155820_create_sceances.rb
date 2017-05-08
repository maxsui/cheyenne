class CreateSceances < ActiveRecord::Migration[5.1]
  def change
    create_table :sceances do |t|
      t.datetime :begin
      t.datetime :end

      t.timestamps
    end

    create_table :sceance_customers do |t|
      t.belongs_to :sceance
      t.belongs_to :customer

      t.timestamps
    end
  end
end
