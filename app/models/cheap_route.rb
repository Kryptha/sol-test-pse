class CheapRoute < ApplicationRecord

  def to_jsonapi
    {
      type: :routes,
      id: "#{from}-#{to}",
      attributes: { from: from, to: to, price: "USD " + price.ceil.to_s, airline: airline, departs_at: departs_at }
    }
  end
end
