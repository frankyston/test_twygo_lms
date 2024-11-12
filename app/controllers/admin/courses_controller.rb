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
      redirect_to admin_courses_path, notice: I18n.t('created', model: Course.model_name.human)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: I18n.t('updated', model: Course.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path, notice: I18n.t('destroyed', model: Course.model_name.human)
  end

  def report
    @course = @current_user.courses.find(params[:course_id])
    # TODO: Levar esse algoritmo para um background job
    if @course.present?
      respond_to do |format|
        format.csv do
          file_path = ReportCsv.new(@course).call
          send_file file_path, type: 'text/csv', filename: "report_#{@course.title.parameterize}-#{Time.current.strftime('%Y%m%d%H%M%S')}.csv"
        end
      end
    else
      redirect_to admin_courses_path, alert: I18n.t('not_found', model: Course.model_name.human)
    end
  end

  private

  def set_course
    @course = @current_user.courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :instructor, :started_at, :ended_at, :cover, :short_description)
  end
end
