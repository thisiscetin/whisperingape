class AddActiveToEmbeddings < ActiveRecord::Migration[7.0]
  def change
    add_column :embeddings, :active, :boolean, default: true
  end
end
