class CreateRouteOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :route_options do |t|
      t.string :from
      t.string :to
      t.datetime :departs_at
      t.datetime :arrives_at
      t.belongs_to :route_capture, null: false, foreign_key: true
      t.string :airline_ref
      t.text :raw_payload
      t.decimal :price

      t.timestamps
    end
  end
end
