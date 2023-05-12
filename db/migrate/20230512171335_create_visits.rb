class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.string :destination, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
