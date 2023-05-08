class CreateApes < ActiveRecord::Migration[7.0]
  def change
    create_table :apes do |t|
      t.string :host, null: false
      t.integer :refresh_in_hours, null: false, default: 24

      t.boolean :follow_up, null: false, default: true
      t.boolean :active, null: false, default: true

      t.datetime :last_run
      t.timestamps
    end
  end
end
