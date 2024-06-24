class AddIsReceivedToPackages < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :is_received, :boolean
  end
end
