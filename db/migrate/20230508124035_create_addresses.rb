class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'vector'

    create_table :addresses do |t|
      t.string :destination, null: false
      
      # post crawl
      t.text :content
      t.string :md5sum

      t.boolean :visited, null: false, default: false
      t.boolean :processing, null: false, default: false

      t.references :ape, null: false
      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE addresses ADD embedding vector(1536);
    SQL
  end
end
