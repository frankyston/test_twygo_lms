class Admin::BaseController < ApplicationController
  layout 'internal'
  before_action :require_admin

  private

  def require_admin
    redirect_to root_path, alert: 'Você não tem permissão para acessar esta área.' unless Current.user.admin?
  end
end
