class Lesson < ApplicationRecord
  belongs_to :course

  has_one_attached :thumbnail
  has_one_attached :file

  before_save :set_file_size

  def set_file_size
    self.file_size = self.file.byte_size
  end

  def bytes_to_megabytes
    (self.file_size / (1024.0 * 1024.0)).round(2)
  end
end
