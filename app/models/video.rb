class Video < ActiveRecord::Base

  has_and_belongs_to_many :lists

  validates :unique_id, presence: true
  validates :unique_id, uniqueness: true

end