class RenameSceanceIntoSeance < ActiveRecord::Migration[5.1]
  def change
    rename_table :sceance_customer_observables, :seance_customer_observables

    rename_table :sceance_customers, :seance_customers
    rename_table :sceance_groups, :seance_groups
    rename_table :sceance_users, :seance_users
    rename_table :sceances, :seances

    rename_indexed_column :seance_customer_observables, :sceance_customer_id, :seance_customer_id
    rename_indexed_column :seance_customers, :sceance_id, :seance_id
    rename_indexed_column :seance_groups, :sceance_id, :seance_id
    rename_indexed_column :seance_users, :sceance_id, :seance_id
  end

  private

  def rename_indexed_column(table, old, new)
    remove_index table, old
    rename_column table, old, new
    add_index table, new
  end
end
