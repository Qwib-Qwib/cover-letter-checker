class Offer < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy

  validates :title, :content, presence: true
  validates :title, length: { maximum: 100 }
  validates :content, length: { in: 1000..5500 }
end
