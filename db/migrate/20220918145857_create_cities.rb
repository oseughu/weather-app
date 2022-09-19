class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :sunrise
      t.string :sunset

      t.timestamps
    end
  end
end
