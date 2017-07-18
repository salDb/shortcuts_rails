class CreateCommands < ActiveRecord::Migration[5.1]
  def change
    create_table :commands do |t|
      t.string :command_description
      t.string :command
      t.references :app, index: true, foreign_key: true
      t.timestamps
    end
  end
end
