class CoursesController < ApplicationController
  layout 'internal'

  def show
    @course = Course.find(params[:id])
  end
end
