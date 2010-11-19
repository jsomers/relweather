class Simplify < ActiveRecord::Migration
  def self.up
    remove_column :forecasts, :low
    remove_column :forecasts, :high
    remove_column :forecasts, :date
    add_column :forecasts, :time, :datetime
  end

  def self.down
    add_column :forecasts, :low, :integer
    add_column :forecasts, :high, :integer
    add_column :forecasts, :date, :date
    remove_column :forecasts, :time
  end
end
