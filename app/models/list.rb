class List < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :videos, dependent: :destroy

  validates :name, :user_id, presence: true

end