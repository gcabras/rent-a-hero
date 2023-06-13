class CreateSuperheros < ActiveRecord::Migration[7.0]
  def change
    create_table :superheros do |t|
      t.string :name
      t.integer :intelligence
      t.integer :strength
      t.integer :hero_speed
      t.integer :speed
      t.integer :durability
      t.integer :power
      t.integer :combat
      t.string :full_name
      t.string :place_of_birth
      t.string :alignment
      t.string :race
      t.string :occupation
      t.string :base
      t.text :affiliation

      t.timestamps
    end
  end
end
