require "streamio-ffmpeg"

class ProcessVideo
  def initialize(lesson)
    @lesson = lesson
  end

  def call
    set_duration
    set_file_size
    @lesson.save
  end

  private

  def file_path
    ActiveStorage::Blob.service.send(:path_for, @lesson.file.key)
  end

  def set_duration
    @lesson.duration = (::FFMPEG::Movie.new(file_path).duration / 60).round(2)
  end

  def set_file_size
    @lesson.file_size = @lesson.file.byte_size
  end
end
