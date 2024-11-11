class EnrollmentsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    if @course
      if @current_user.my_courses.include?(@course)
        redirect_to course_lesson_path(@course, @course.lessons.first), alert: "Você já está inscrito neste curso!"
      else
        @enrollment = @current_user.enrollments.create(course: @course)
        redirect_to course_lesson_path(@course, @course.lessons.first), notice: "Você se inscreveu no curso com sucesso!"
      end
    else
      redirect_to course_lesson_path(@course, @course.lessons.first), alert: "Curso não encontrado!"
    end
  end
end
