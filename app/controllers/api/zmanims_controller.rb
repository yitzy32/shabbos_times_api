class Api::ZmanimsController < ApplicationController
  def show
    next_friday = Date.today.end_of_week(:saturday)
    ap next_friday

    response = HTTP.get("https://www.hebcal.com/zmanim?cfg=json&zip=#{params[:zipcode]}&date=#{next_friday}")
    @data = JSON.parse(response)

    zmanim = {}
    zmanim[:date] = Date.parse(@data["date"]).strftime("%A %B %e")
    zmanim[:name] = @data["location"]["name"]
    zmanim[:mincha_gedola] = DateTime.parse(@data["times"]["minchaGedola"]).strftime("%l:%M:%S %p")
    zmanim[:plag_hamincha] = DateTime.parse(@data["times"]["plagHaMincha"]).strftime("%l:%M:%S %p")
    zmanim[:sunset] = DateTime.parse(@data["times"]["sunset"]).strftime("%l:%M:%S %p")
    zmanim[:tzeis_50_min] = DateTime.parse(@data["times"]["tzeit50min"]).strftime("%l:%M:%S %p")
    zmanim[:tzeis_72_min] = DateTime.parse(@data["times"]["tzeit72min"]).strftime("%l:%M:%S %p")
    ap zmanim

    selected_day = Date.parse(zmanim[:date])
    plus_1_week = Date.parse(zmanim[:date]) + 7

    convert_to_sring = plus_1_week.strftime("%Y/%m/%d")
    render "show.json.jb"
  end
end
