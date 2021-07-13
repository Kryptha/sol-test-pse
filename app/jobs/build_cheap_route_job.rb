# Builds the cheapest route possible between all nodes
class BuildCheapRouteJob < ApplicationJob
  queue_as :default

  def perform
    uc = UseCases::BuildCheapRoute.new.execute
    return unless uc.valid?

    uc.execute
  end
end
