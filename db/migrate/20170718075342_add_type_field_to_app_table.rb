class AddTypeFieldToAppTable < ActiveRecord::Migration[5.1]
  def change
    add_column :apps, :app_type, :integer
  end
end
