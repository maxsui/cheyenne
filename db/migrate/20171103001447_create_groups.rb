class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    create_table :group_memberships do |t|
      t.belongs_to :group
      t.belongs_to :customer

      t.timestamps
    end
  end
end
