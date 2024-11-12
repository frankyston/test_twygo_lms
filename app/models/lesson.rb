class Lesson < ApplicationRecord
  belongs_to :course

  has_one_attached :thumbnail
  has_one_attached :file

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :short_description, presence: true, length: { maximum: 100 }

  def bytes_to_megabytes
    (self.file_size / (1024.0 * 1024.0)).round(2)
  end

  def processed?
    self.duration.positive? && self.file_size.positive?
  end
end
