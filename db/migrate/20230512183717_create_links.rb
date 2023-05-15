class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :destination, null: false, index: { unique: true }

      t.references :ape, foreign_key: true
      t.timestamps
    end
  end
end
