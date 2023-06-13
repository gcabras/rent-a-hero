class RemoveHeroSpeedFromSuperheros < ActiveRecord::Migration[7.0]
  def change
    remove_column :superheros, :hero_speed, :integer
  end
end
