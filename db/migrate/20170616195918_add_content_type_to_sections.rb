class AddContentTypeToSections < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :content_type, :string
  end
end
