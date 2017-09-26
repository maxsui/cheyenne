class CreateObservableCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :observable_categories do |t|
      t.string :name
      t.timestamps
    end

    ObservableCategory.reset_column_information
    default_category = ObservableCategory.create! name: "Autre"

    change_table :observables do |t|
      t.belongs_to :observable_category
    end

    Observable.reset_column_information
    Observable.update_all observable_category_id: default_category.id
  end
end
