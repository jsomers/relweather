class Forecast < ActiveRecord::Base
  
  def self.hit_google_api(q)
    q = CGI::escape(q)
    `curl --silent http://www.google.com/ig/api?weather=#{q}`
  end
  
  def self.have_for_city(city)
    Forecast.count(:all, :conditions => ["city = ?", city]) > 0
  end
  
  def self.get(q, auto=false)
    require 'rexml/document'
    include REXML
    
    def self.el(node, name)
      node.elements[name].attributes["data"]
    end
    
    begin
      doc = Document.new Forecast.hit_google_api(q)
      meta = doc.elements["/xml_api_reply/weather/forecast_information"]
      current = doc.elements["/xml_api_reply/weather/current_conditions"]
      f = {
        :time => Time.now,
        :city => (c = el(meta, "city") ),
        :zip_code => el(meta, "postal_code"),
        :current_temperature => el(current, "temp_f"),
        :humidity => el(current, "humidity")[/Humidity: (\d+)%/, 1],
        :conditions => el(current, "condition"),
        :wind => el(current, "wind_condition")
      }
      
      if !Forecast.have_for_city(c) or auto
        Forecast.create(f)
      end
      
      return f
    rescue Exception => e
      puts e
    end
  end
  
  def self.all_within_window_for_city(strt, nd, city)
    Forecast.find(:all, 
      :conditions => [
        "time >= ? and time <= ? and city = ?",
        strt, nd, city
      ]
    ).collect(&:current_temperature)
  end
  
  def self.diff(olds, today)
    yesterday = olds.sum / olds.length.to_f
    dir = (today > yesterday) ? "warmer" : "colder"
    mag = (today - yesterday).abs.round(2)
    [mag, dir]
  end
  
  def self.relative(q, strt=35.minutes.ago, nd=35.minutes.from_now)
    t = Forecast.get(q)
    yesterdays = if t then Forecast.all_within_window_for_city(strt - 1.day, nd - 1.day, t[:city]) else [] end
    if yesterdays.empty? then return nil end
    [t, Forecast.diff(yesterdays, t[:current_temperature].to_i)]
  end

end