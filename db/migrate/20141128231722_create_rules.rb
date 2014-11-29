class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :gifter
      t.string :recipient
      t.references :santa, index: true

      t.timestamps
    end
  end
end
