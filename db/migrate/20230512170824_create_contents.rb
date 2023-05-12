class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.string :first_seen, null: false
      
      t.string :md5sum, null: false, index: { unique: true }
      t.text :markup, null: false

      # post visit
      t.vector :embedding, limit: 1536

      t.boolean :active, null: false, default: true

      t.references :ape
      t.timestamps
    end
  end
end
