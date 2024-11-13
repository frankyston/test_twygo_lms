require "streamio-ffmpeg"
require 'open-uri'
require 'fileutils'

class ProcessVideo
  def initialize(lesson)
    @lesson = lesson
  end

  def call
    if Rails.env.production?
      download_and_process
    else
      process_local
    end
  end

  private

  def download_and_process
    create_temp_file
    process_video(@temp_file_path)
  ensure
    cleanup_temp_file
  end

  def process_local
    file_path = ActiveStorage::Blob.service.send(:path_for, @lesson.file.key)
    process_video(file_path)
  end

  def process_video(path)
    set_duration(path)
    set_file_size
    @lesson.save
  end

  def create_temp_file
    FileUtils.mkdir_p(Rails.root.join('tmp', 'videos'))
    @temp_file_path = Rails.root.join('tmp', 'videos', "#{@lesson.file.key}.mp4").to_s
    download_from_s3
    @temp_file_path
  end

  def download_from_s3
    url = @lesson.file.url
    File.open(@temp_file_path, 'wb') do |file|
      file << URI.open(url).read
    end
  end

  def set_duration(path)
    movie = ::FFMPEG::Movie.new(path)
    @lesson.duration = (movie.duration / 60).round(2)
  end

  def set_file_size
    @lesson.file_size = @lesson.file.byte_size
  end

  def cleanup_temp_file
    File.delete(@temp_file_path) if File.exist?(@temp_file_path)
  end
end
