class EnrollmentsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    if @course
      if @current_user.my_courses.include?(@course)
        redirect_to course_path(@course), alert: "Você já está inscrito neste curso!"
      else
        @enrollment = @current_user.enrollments.create(course: @course)
        redirect_to course_path(@course), notice: "Você se inscreveu no curso com sucesso!"
      end
    else
      redirect_to course_path(@course), alert: "Curso não encontrado!"
    end
  end
end
