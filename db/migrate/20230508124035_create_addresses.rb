class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :destination, null: false, index: { unique: true }
      
      # post crawl
      t.text :content
      t.string :md5sum

      t.boolean :active, null: false, default: true

      t.references :ape, null: false
      t.timestamps
    end
  end
end
