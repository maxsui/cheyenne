class CreateSessionCustomerObservables < ActiveRecord::Migration[5.1]
  def change
    create_table :session_customer_observables do |t|
      t.belongs_to :session_customer
      t.belongs_to :project_observable

      t.integer :note
      t.belongs_to :user

      t.timestamps
    end
  end
end
