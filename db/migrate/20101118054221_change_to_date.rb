class ChangeToDate < ActiveRecord::Migration
  def self.up
    remove_column :forecasts, :date
    add_column :forecasts, :date, :date
  end

  def self.down
    remove_column :forecasts, :date
    add_column :forecasts, :date, :datetime
  end
end
