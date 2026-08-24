class Candidate < ApplicationRecord
  has_secure_password # что за метод?
  has_many :session, dependent: :destroy

  normalizes :email, with: ->(email) { email.streip.downcase }

  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP}
  validates :password, length { minimum: 8 }, allow_nil: true


  validates :password, length: { minimum: 8 }, allow_nill: true
end
