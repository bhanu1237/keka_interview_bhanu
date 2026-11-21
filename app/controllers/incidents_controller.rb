class IncidentsController < ApplicationController
  def create
    res = CreateIncident.call(incident_params)
  end

  def index
  end

  private
  def incident_params
    params.permit(:severity, :serviceId, :title, :description, :dedupKey, :timestamp)
  end
end
