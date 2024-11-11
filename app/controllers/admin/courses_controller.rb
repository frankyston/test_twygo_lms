class Admin::CoursesController < Admin::BaseController
  before_action :set_course, only: [:edit, :show, :update, :destroy]

  def index
    @courses = @current_user.courses.all
  end

  def new
    @course = @current_user.courses.new
  end

  def show
    @lessons = @course.lessons
  end

  def create
    @course = @current_user.courses.new(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: 'Curso criado com sucesso'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: 'Curso atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path, notice: 'Curso deletado com sucesso'
  end

  private

  def set_course
    @course = @current_user.courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :instructor, :started_at, :ended_at, :cover)
  end
end
