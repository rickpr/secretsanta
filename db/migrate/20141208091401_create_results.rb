class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :gifter
      t.string :recipient
      t.references :group, index: true

      t.timestamps
    end
  end
end
