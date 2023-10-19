class Offer < ApplicationRecord
  belongs_to :user
  has_many :applications, dependent: :destroy

  validates :title, :content, presence: true
end
