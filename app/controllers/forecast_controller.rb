class ForecastController < ApplicationController
  def index
    `curl http://www.google.com/ig/api?weather=Mountain+View`
  end
end
