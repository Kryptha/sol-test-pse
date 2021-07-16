class RouteOption < ApplicationRecord
  belongs_to :route_capture

  scope :in, ->(time) { where(created_at: time.ago..1.second.ago) }
  scope :clean, -> (time) { where(created_at: 1.day.ago...time.ago).delete_all}
  scope :origin, ->(loc) { where(from: loc) }
  scope :destination, ->(loc) { where(to: loc) }
  scope :airline, ->(loc) { where(airline_ref: loc) } 
  scope :cheaper, -> { order(price: :asc) }
  scope :earliest_departure, -> { order(departs_at: :asc) }

  def payload
    Oj.load raw_payload
  end
end
