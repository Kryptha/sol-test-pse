class CheapRoute < ApplicationRecord

  def to_jsonapi
    {
      type: :routes,
      id: "#{from}-#{to}",
      attributes: { from: from, to: to, price: price, airline: airline, departs_at: departs_at }
    }
  end
end
