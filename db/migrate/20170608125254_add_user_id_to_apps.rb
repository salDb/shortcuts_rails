class AddUserIdToApps < ActiveRecord::Migration[5.1]
  def change
    add_reference :apps, :user, index: true
  end
end
