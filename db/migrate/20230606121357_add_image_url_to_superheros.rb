class AddImageUrlToSuperheros < ActiveRecord::Migration[7.0]
  def change
    add_column :superheros, :image_url, :string
  end
end
