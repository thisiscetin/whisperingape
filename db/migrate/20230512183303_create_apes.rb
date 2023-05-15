class CreateApes < ActiveRecord::Migration[7.0]
  def change
    create_table :apes do |t|
      t.string :domain, null: false, index: { unique: true }

      t.boolean :discovery, null: false, default: true
      t.boolean :subdomain_followup, null: false, default: false

      t.timestamps
    end
  end
end
