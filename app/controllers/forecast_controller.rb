class ForecastController < ApplicationController
  def search
  end
  
  def redirect_search
    s = params[:q].downcase.gsub(/[^a-z0-9\,]/, "-").gsub(",-", "-")
    redirect_to :controller => "forecast", :action => "for", :id => s
  end
  
  def for
    f = Forecast.relative(params[:id].gsub("-", " "))
    if f.nil?
      render :text => <<-eof
        You're the first person to search for the forecast in this area.
        Unfortunately, that means we don't have any data from yesterday to compare your forecast to. <br/><br/>
        But our server has been notified, and we'll have some results for you tomorrow. Do come back!
      eof
      return false
    else
      @forecast = f.to_json
    end
  end
end