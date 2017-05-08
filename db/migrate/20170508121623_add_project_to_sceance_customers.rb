class AddProjectToSceanceCustomers < ActiveRecord::Migration[5.1]
  def change
    add_reference :sceance_customers, :project, foreign_key: true
  end
end
