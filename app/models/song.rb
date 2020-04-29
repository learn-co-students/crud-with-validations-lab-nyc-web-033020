class Song < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: :release_year,
    message: "You cannot release a song twice in the same year" }
  validates :release_year, presence: true, if: :released
  validate :valid_release_year, if: :release_year

  def valid_release_year
    current_year = Time.now.year
    
    if self.release_year > current_year
      errors.add(:release_year, "Can't be in the future")
    end
  end
end
