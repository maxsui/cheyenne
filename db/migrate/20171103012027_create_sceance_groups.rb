class CreateSceanceGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :sceance_groups do |t|
      t.belongs_to :sceance
      t.belongs_to :group

      t.timestamps
    end
  end
end
