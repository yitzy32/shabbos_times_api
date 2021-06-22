class Api::ZmanimsController < ApplicationController
  def index
    response = HTTP.get("https://www.hebcal.com/zmanim?cfg=json&zip=11210&date=2021-06-21")
    @data = JSON.parse(response)

    zmanim = {}
    zmanim[:date] = @data["date"]
    zmanim[:name] = @data["location"]["name"]
    zmanim[:zip] = @data["location"]["zip"]
    zmanim[:minchaGedola] = @data["times"]["minchaGedola"]
    zmanim[:plagHaMincha] = @data["times"]["plagHaMincha"]
    zmanim[:sunset] = @data["times"]["sunset"]
    zmanim[:tzeit50min] = @data["times"]["tzeit50min"]
    zmanim[:tzeit72min] = @data["times"]["tzeit72min"]
    ap zmanim
    render "index.json.jb"
  end
end
