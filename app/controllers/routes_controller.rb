class RoutesController < ApplicationController
  before_action :set_routes

  def index
    origins = @routes.distinct(:from).pluck(:from)
    origins_json = origins.map { |o| { type: :origins, id: o } }
    render json: { data: origins_json }
  end

  def show
    routes = @routes.where(**route_params.to_h)
    render json: { data: routes.map(&:to_jsonapi) }
  end

  def show_airline
    @routes.where(departs_at: 1.week.ago...1.second.ago)
    routes = @routes.where(**route_params.to_h)
    render json: { data: routes.map(&:to_jsonapi) }
  end

  def route_params
    params.permit(:from, :to, :airline)
  end

  def set_routes
    @routes = CheapRoute.where(created_at: 10.hours.ago..1.second.ago)
  end
end
