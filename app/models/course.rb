class Course < ApplicationRecord
  has_many :enrollments
  has_many :users, through: :enrollments

  has_one_attached :cover

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :instructor, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true
  validate :validate_ended_at

  validates :short_description, presence: true, length: { maximum: 100 }

  before_destroy :destroy_enrollments

  has_many :lessons, dependent: :destroy
  belongs_to :user

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
  end

  def self.inactive
    where('started_at <= ? AND ended_at < ?', Date.today, Date.today)
  end

  def validate_ended_at
    errors.add(:ended_at, 'deve ser maior que a data de início') if ended_at.present? && ended_at <= started_at
  end

  def total_duration_in_minutes
    lessons.all.sum(&:duration)
  end

  def total_size_in_megabytes
    lessons.all.sum(&:bytes_to_megabytes).round(2)
  end

  def destroy_enrollments
    Enrollment.where(course_id: self.id).destroy_all
  end
end
