class CreateScrapes < ActiveRecord::Migration[7.0]
  def change
    create_table :scrapes do |t|
      t.text :content, null: false
      t.text :gpt_content
      
      t.string :md5sum, null: false, index: { unique: true }

      t.references :ape, foreign_key: true
      t.references :link, foreign_key: true
      t.timestamps
    end
  end
end
