class Superhero < ApplicationRecord
  geocoded_by :base

  before_create :geocode, if: :will_save_change_to_base?
end
