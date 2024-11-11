class HomeController < ApplicationController
  layout 'internal'

  def index
    @courses = Course.active.order(created_at: :desc)
    if params[:my_courses]
      @courses = @courses.where(id: Enrollment.where(user_id: @current_user.id).pluck(:course_id)).order(created_at: :desc)
    else
      @courses = @courses.where.not(id: Enrollment.where(user_id: @current_user.id).pluck(:course_id)).order(created_at: :desc)
    end
  end
end
