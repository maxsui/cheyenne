class AddProjectToSessionCustomers < ActiveRecord::Migration[5.1]
  def change
    add_reference :session_customers, :project, foreign_key: true
  end
end
