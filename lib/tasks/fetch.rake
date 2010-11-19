namespace :fetch do
  task :initials => :environment do
    f = File.open("#{RAILS_ROOT}/lib/cities.txt");
    cities = f.read.split("\n");
    cities.each do |c|
      Forecast.get(c)
    end
  end
  
  task :hourlies => :environment do
    Forecast.all.collect(&:city).each do |c|
      Forecast.get(c, auto = true)
    end
  end
end