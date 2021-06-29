class Api::ZmanimsController < ApplicationController
  def index
    @calendar_of_fridays = []
    starting_date = Date.parse("march 7 #{Date.today.year}")

    next_friday = starting_date.end_of_week(:saturday)
    35.times do
      response = HTTP.get("https://www.hebcal.com/zmanim?cfg=json&zip=#{params[:search]}&date=#{next_friday}")
      @data = JSON.parse(response)

      @zmanim = {}
      @zmanim[:date] = Date.parse(@data["date"]).strftime("%A %B %e")
      @zmanim[:name] = @data["location"]["name"]
      @zmanim[:mincha_gedola] = DateTime.parse(@data["times"]["minchaGedola"]).strftime("%l:%M %p")
      @zmanim[:mincha] = DateTime.parse(@data["times"]["plagHaMincha"]) - 15.minutes
      @zmanim[:mincha] = @zmanim[:mincha].strftime("%l:%M %p")
      @zmanim[:plag_hamincha] = DateTime.parse(@data["times"]["plagHaMincha"]).strftime("%l:%M %p")
      @zmanim[:candle_lighting] = DateTime.parse(@data["times"]["sunset"]) - 18.minutes
      @zmanim[:candle_lighting] = @zmanim[:candle_lighting].strftime("%l:%M %p")
      @zmanim[:sunset] = DateTime.parse(@data["times"]["sunset"]).strftime("%l:%M %p")
      @zmanim[:tzeis50min_fri_night] = DateTime.parse(@data["times"]["tzeit50min"]).strftime("%l:%M %p")
      @zmanim[:tzeis72min_fri_night] = DateTime.parse(@data["times"]["tzeit72min"]).strftime("%l:%M %p")

      next_friday += 7
      @calendar_of_fridays << @zmanim
    end

    render "index.json.jb"
  end

  def show
    next_friday = Date.today.end_of_week(:saturday)

    response = HTTP.get("https://www.hebcal.com/zmanim?cfg=json&zip=#{params[:search]}&date=#{next_friday}")
    @data = JSON.parse(response)

    @zmanim = {}
    @zmanim[:date] = Date.parse(@data["date"]).strftime("%A %B %e")
    @zmanim[:name] = @data["location"]["name"]
    @zmanim[:mincha_gedola] = DateTime.parse(@data["times"]["minchaGedola"]).strftime("%l:%M %p")
    @zmanim[:mincha] = DateTime.parse(@data["times"]["plagHaMincha"]) - 15.minutes
    @zmanim[:mincha] = @zmanim[:mincha].strftime("%l:%M %p")
    @zmanim[:plag_hamincha] = DateTime.parse(@data["times"]["plagHaMincha"]).strftime("%l:%M %p")
    @zmanim[:candle_lighting] = DateTime.parse(@data["times"]["sunset"]) - 18.minutes
    @zmanim[:candle_lighting] = @zmanim[:candle_lighting].strftime("%l:%M %p")
    @zmanim[:sunset] = DateTime.parse(@data["times"]["sunset"]).strftime("%l:%M %p")
    @zmanim[:tzeis50min_fri_night] = DateTime.parse(@data["times"]["tzeit50min"]).strftime("%l:%M %p")
    @zmanim[:tzeis72min_fri_night] = DateTime.parse(@data["times"]["tzeit72min"]).strftime("%l:%M %p")
    ap @zmanim

    render "show.json.jb"
  end
end
