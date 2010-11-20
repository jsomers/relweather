namespace :fetch do
  task :initials => :environment do
    f = File.open("#{RAILS_ROOT}/lib/cities.txt");
    cities = f.read.split("\n");
    cities.each do |c|
      puts "Fetching forecast for #{c}..."
      Forecast.get(c)
      puts "  > done."
    end
  end
  
  task :hourlies => :environment do
    Forecast.all.collect(&:city).uniq.each do |c|
      puts "Fetching forecast for #{c}..."
      Forecast.get(c, auto = true)
      puts "  > done."
    end
    Forecast.find(:all, :conditions => ["time < ?", 2.days.ago]).each {|f| f.destroy}
  end
end