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


# .present? — true, если объект не nil, не false и не "пустой", 
# (для строки — не пустая строка, для массива — не пустой массив и т.д.); относится к Active Support
# .blank? — противоположность: true, если объект nil, false, пустая строка, 
# пустой массив/хеш и т.д.; относится к Active Support
# :base — специальный символ, означающий "ошибка относится ко всей записи в целом", а не к конкретному полю 
# (используется, когда проверка затрагивает несколько атрибутов сразу)