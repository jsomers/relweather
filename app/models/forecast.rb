class Forecast < ActiveRecord::Base
  
  def self.hit_google_api(q)
    q = CGI::escape(q)
    `curl --silent http://www.google.com/ig/api?weather=#{q}`
  end
  
  def self.have_for_date_and_city(date, city)
    Forecast.find_by_date_and_city(date, city)
  end
  
  def self.get(q)
    require 'rexml/document'
    include REXML
    
    def self.el(node, name)
      node.elements[name].attributes["data"]
    end
    
    doc = Document.new Forecast.hit_google_api(q)
    meta = doc.elements["/xml_api_reply/weather/forecast_information"]
    current = doc.elements["/xml_api_reply/weather/current_conditions"]
    forecast = doc.elements["/xml_api_reply/weather/forecast_conditions"]
    f = {
      :date => ( d = Date.parse(el(meta, "forecast_date")) ),
      :city => (c = el(meta, "city") ),
      :zip_code => el(meta, "postal_code"),
      :current_temperature => el(current, "temp_f"),
      :low_temperature => el(forecast, "low"),
      :high_temperature => el(forecast, "high"),
      :humidity => el(current, "humidity")[/Humidity: (\d+)%/, 1],
      :conditions => el(current, "condition"),
      :wind => el(current, "wind_condition")
    }
    
    if !Forecast.have_for_date_and_city(d, c)
      Forecast.create(f)
    end
    
    f
  end
  
  def average_temperature
    (self.low_temperature + self.high_temperature) / 2.0
  end
  
  def self.diff(yesterday, today)
    dir = (today > yesterday) ? "warmer" : "colder"
    mag = (today - yesterday).abs.round(2)
    [mag, dir]
  end
  
  def self.relative(q)
    t = Forecast.get(q)
    yesterday = Forecast.find_by_date_and_city(Date.yesterday, t[:city])
    Forecast.diff(yesterday.average_temperature, t[:current_temperature].to_i)
  end

end