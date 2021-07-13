# Loads all routes 
class LoadDataJob < ApplicationJob
  queue_as :default

  AIRPORT_CODES = %w[UIO SCL MDZ LIM ZAL PMC].freeze
  def perform
    AIRPORT_CODES.each do |from|
      AIRPORT_CODES.each do |to|
        LoadRouteJob.perform_later(from, to)
      end
    end
  end
end
