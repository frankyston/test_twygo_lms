class Course < ApplicationRecord
  #has_many :enrollments
  #has_many :users, through: :enrollments

  validates :title, presence: true
  validates :description, presence: true
  validates :instructor, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
  validate :validate_ended_at

  has_many :lessons, dependent: :destroy

  def started?
    started_at <= Date.today
  end

  def ended?
    ended_at < Date.today
  end

  def active?
    started? && !ended?
  end

  def inactive?
    !started? || ended?
  end

  def self.active
    where('started_at <= ? AND ended_at >= ?', Date.today, Date.today)
    # 8 <= 8 and 10 >= 8
  end

  def self.inactive
    where('started_at <= ? AND ended_at < ?', Date.today, Date.today)
    # 8 <= 8 and 10 < 8
  end

  def validate_ended_at
    errors.add(:ended_at, 'deve ser maior que a data de início') if ended_at.present? && ended_at <= started_at
  end

  def total_size_in_megabytes
    lessons.all.sum(&:bytes_to_megabytes)
  end
end
