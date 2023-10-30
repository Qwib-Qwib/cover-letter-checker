class JobApplication < ApplicationRecord
  belongs_to :offer

  validates :applicant_name, :content, presence: true
  validates :applicant_name, length: { maximum: 100 }
  validates :content, length: { in: 100..3500 }, if: :content?
end
