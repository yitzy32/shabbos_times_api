class Api::ZmanimsController < ApplicationController
  def index
    response = HTTP.get("https://www.hebcal.com/zmanim?cfg=json&zip=11210&date=2021-06-21")
    @data = JSON.parse(response)
    ap @data
    render "index.json.jb"
  end
end
