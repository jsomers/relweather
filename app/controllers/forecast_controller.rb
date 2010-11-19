class ForecastController < ApplicationController
  def search
  end
  
  def redirect_search
    s = params[:q].downcase.gsub(/[^a-z0-9\,]/, "-").gsub(",-", "-")
    redirect_to :controller => "forecast", :action => "for", :id => s
  end
  
  def for
    @forecast = Forecast.relative(params[:id].gsub("-", " "))
  end
end