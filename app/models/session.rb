class Session < ApplicationRecord
  belongs_to :candidate, optional: true
  belongs_to :employer, optional: true


  before_validation(on: :create) { self.token ||= SecureRandom.hex(32) }

  validates :token, presence: true, uniqueness: true # встроенный метод валидации рельсы

  validate :belongs_to_candidate_or_employer # собственный метод валидации


  private

  def belongs_to_candidate_or_employer
    if candidate.present? && employer.present?
      errors.add(:base, "Session cannot belong to both a candidate and an employer")
    elsif candidate.blank? && employer.blank?
      errors.add(:base, "Session must belong to either a candidate or an employer")
    end
  end
end
