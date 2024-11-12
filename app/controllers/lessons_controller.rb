class LessonsController < ApplicationController
  layout 'internal'

  def show
    @course = Course.find(params[:course_id])
    if @current_user.my_courses.include?(@course)
      @lesson = @course.lessons.find(params[:id])
    else
      redirect_to root_path, alert: I18n.t('not_allowed', model: Lesson.model_name.human)
    end
  end
end
