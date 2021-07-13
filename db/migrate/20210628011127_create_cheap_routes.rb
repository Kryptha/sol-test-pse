class CreateCheapRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :cheap_routes do |t|
      t.string :from
      t.string :to
      t.string :airline
      t.decimal :price
      t.datetime :departs_at

      t.timestamps
    end
  end
end
