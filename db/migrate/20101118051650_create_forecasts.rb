class CreateForecasts < ActiveRecord::Migration
  def self.up
    create_table :forecasts do |t|
      t.datetime :date
      t.string :zip_code
      t.string :city
      t.integer :current_temperature
      t.integer :low_temperature
      t.integer :high_temperature
      t.integer :humidity
      t.string :conditions
      t.string :wind
      t.timestamps
    end
  end

  def self.down
    drop_table :forecasts
  end
end
