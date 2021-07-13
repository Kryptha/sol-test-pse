# Loads the available information for a route
class LoadRouteJob < ApplicationJob
  queue_as :default

  def perform(from, to)
    uc = UseCases::LoadIncomingRoutes.new(from: from, to: to)
    return unless uc.valid?

    uc.execute
    route_capture = uc.result
    route_capture.schedule!
  end
end
