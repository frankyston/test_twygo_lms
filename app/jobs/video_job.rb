class VideoJob < ApplicationJob
  queue_as :videos

  def perform(lesson_id)
    lesson = Lesson.find(lesson_id)
    ProcessVideo.new(lesson).call
  end
end
