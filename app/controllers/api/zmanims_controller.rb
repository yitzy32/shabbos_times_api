class Api::ZmanimsController < ApplicationController
  def index
    response = HTTP.get("https://www.hebcal.com/zmanim?cfg=json&zip=#{params[:zipcode]}&date=#{params[:date]}")
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

    selected_day = Date.parse(zmanim[:date])
    plus_1_week = Date.parse(zmanim[:date]) + 7

    convert_to_sring = plus_1_week.strftime("%Y/%m/%d")
    render "index.json.jb"
  end
end
