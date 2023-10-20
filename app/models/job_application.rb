class JobApplication < ApplicationRecord
  belongs_to :offer

  validates :applicant_name, :content, presence: true
end
