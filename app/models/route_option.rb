class RouteOption < ApplicationRecord
  belongs_to :route_capture

  scope :in, ->(time) { where(created_at: time.ago..1.second.ago) }
  scope :origin, ->(loc) { where(from: loc) }
  scope :destination, ->(loc) { where(to: loc) }
  scope :cheaper, -> { order(price: :asc) }
  scope :earliest_departure, -> { order(departs_at: :asc) }

  def payload
    Oj.load raw_payload
  end
end
