class LessonsController < ApplicationController
  layout 'internal'

  def show
    @course = Course.find(params[:course_id])
    if @current_user.my_courses.include?(@course)
      @lesson = @course.lessons.find(params[:id])
    else
      redirect_to root_path, alert: "Você não tem permissão para acessar esta aula"
    end
  end
end
