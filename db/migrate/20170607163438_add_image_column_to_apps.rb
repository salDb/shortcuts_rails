class AddImageColumnToApps < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :apps, :image
  end

  def down
	remove_attachment :apps, :image
  end

end
