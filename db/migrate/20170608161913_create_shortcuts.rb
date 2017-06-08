class CreateShortcuts < ActiveRecord::Migration[5.1]
  def change
    create_table :shortcuts do |t|
      t.string :action_name
      t.string :first_action
      t.string :second_action
      t.string :third_action
      t.string :fourth_action
      t.references :app, index: true, foreign_key: true
      t.timestamps
    end
  end
end
