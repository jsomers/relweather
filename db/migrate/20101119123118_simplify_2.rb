class Simplify2 < ActiveRecord::Migration
  def self.up
    remove_column :forecasts, :low_temperature
    remove_column :forecasts, :high_temperature
  end

  def self.down
    add_column :forecasts, :low_temperature, :integer
    add_column :forecasts, :high_temperature, :integer
  end
end
