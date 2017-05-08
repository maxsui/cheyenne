class CreateSceanceCustomerObservables < ActiveRecord::Migration[5.1]
  def change
    create_table :sceance_customer_observables do |t|
      t.belongs_to :sceance_customer
      t.belongs_to :project_observable

      t.integer :note
      t.belongs_to :user

      t.timestamps
    end
  end
end
