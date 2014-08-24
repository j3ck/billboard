class DashboardController < ApplicationController
  def index
    unless params[:state].present?
      params[:state] = 'published'
    end
    @adverts = current_user.adverts.where(state: params[:state])
  end
end
