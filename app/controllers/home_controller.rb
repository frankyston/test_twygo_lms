class HomeController < ApplicationController
  layout 'internal'

  def index
    @courses = Course.active
  end
end
