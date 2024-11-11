class Admin::LessonsController < Admin::BaseController
  before_action :set_course
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @lesson = @course.lessons.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    if @lesson.save
      VideoJob.perform_later(@lesson.id)
      redirect_to admin_course_path(@course), notice: 'Aula criada com sucesso'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      VideoJob.perform_later(@lesson.id)
      redirect_to admin_course_path(@course), notice: 'Aula atualizada com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to admin_course_path(@course), notice: 'Aula deletada com sucesso'
  end

  private

  def set_course
    @course = @current_user.courses.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description, :file, :thumbnail)
  end
end
