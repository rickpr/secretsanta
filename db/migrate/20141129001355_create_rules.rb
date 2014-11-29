class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :gifter
      t.string :recipient
      t.references :group, index: true

      t.timestamps
    end
  end
end
