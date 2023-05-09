class AddEmbeddedContentToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :embedding, :vector, limit: 1536
  end
end
