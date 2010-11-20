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
        :wind => el(current, "wind_condition").gsub("Wind: ", "")
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
    ).collect {|f| [f.time.to_i, f.current_temperature]}
  end
  
  def self.relative(q)
    t = Forecast.get(q)
    
    ys = (t ? Forecast.all_within_window_for_city(Date.yesterday, Date.today, t[:city]) : [])
    if ys.empty? then return nil end
    
    t[:time] = t[:time].to_i
    [t, ys, (Date.yesterday + 0.minutes).to_i]
  end

end