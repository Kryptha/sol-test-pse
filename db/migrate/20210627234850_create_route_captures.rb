class CreateRouteCaptures < ActiveRecord::Migration[6.1]
  def change
    create_table :route_captures do |t|
      t.text :raw_payload
      t.string :from
      t.string :to
      t.string :aasm_state

      t.timestamps
    end
  end
end
