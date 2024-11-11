module ApplicationHelper
  def url_to_course(course)
    if @current_user.my_courses.include?(course)
      course_lesson_path(course, course.lessons.first)
    else
      course_path(course)
    end
  end
end
