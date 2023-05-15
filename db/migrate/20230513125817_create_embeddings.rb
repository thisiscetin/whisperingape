class CreateEmbeddings < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'vector'

    create_table :embeddings do |t|
      t.string :destination, null: false, index: { unique: true }
      t.string :md5sum_gpt_content, null: false, index: { unique: true }
      
      t.vector :v, limit: 1536  

      t.references :scrape, foreign_key: true
      t.timestamps
    end
  end
end
