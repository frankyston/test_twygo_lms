class EnrollmentsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    if @course
      if @current_user.my_courses.include?(@course)
        redirect_to course_lesson_path(@course, @course.lessons.first), alert: I18n.t('already_enrolled', model: Course.model_name.human)
      else
        @enrollment = @current_user.enrollments.create(course: @course)
        redirect_to course_lesson_path(@course, @course.lessons.first), notice: I18n.t('enrolled', model: Course.model_name.human)
      end
    else
      redirect_to course_lesson_path(@course, @course.lessons.first), alert: I18n.t('not_found', model: Course.model_name.human)
    end
  end
end
