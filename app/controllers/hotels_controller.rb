class HotelsController < ApplicationController
  def new
    @hotels = []
    
    @largeclass = params[:largeclass]
    @middleclass = params[:middleclass]
    @smallclass = params[:smallclass]
    @detailclass = params[:detailclass]

    if @smallclass.present?
      p "small_class_call"
      uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&largeClassCode=#{@largeclass}&middleClassCode=#{@middleclass}&smallClassCode=#{@smallclass}&detailClassCode=#{@detailclass}&affiliateId=17e357ca.94ed3df2.17e357cb.ba7a82c9&responseType=large&applicationId=1029124388619924322")
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      results = results_json["hotels"]
      results.each do |result|
  
        hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
        unless hotel
          hotel = Hotel.new(read(result))
          hotel.meal_average = nil if hotel.meal_average == 0.0
        end
        @hotels << hotel if hotel.meal_average.present?
        @hotels = @hotels.sort_by{|o| o.meal_average.to_f }.reverse
      end
    end
    
    if params[:keyword].present?
      p "keyword_call"
      @keyword = URI.escape(params[:keyword])
      uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/KeywordHotelSearch/20170426?format=json&\keyword=#{@keyword}&responseType=large&affiliateId=17e357ca.94ed3df2.17e357cb.ba7a82c9&applicationId=1029124388619924322")
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      results = results_json["hotels"]

      results.each do |result|
        hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
        unless hotel
          hotel = Hotel.new(read(result))
          hotel.meal_average = nil if hotel.meal_average == 0.0
        end
        @hotels << hotel if hotel.meal_average.present?
        @hotels = @hotels.sort_by{|o| o.meal_average.to_f }.reverse
      end
    end
    
    if params[:hotelNo].present?
      @hotelNo = URI.escape(params[:hotelNo])
      uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&hotelNo=#{@hotelNo}&affiliateId=17e357ca.94ed3df2.17e357cb.ba7a82c9&responseType=large&applicationId=1029124388619924322")
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      result = results_json["hotels"].first
      
      hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
      unless hotel
        hotel = Hotel.new(read(result))
      end
        @hotels.clear
        @hotels << hotel
    end
  end
  
  def show
    @hotel = Hotel.find(params[:id])
    @like_users = @hotel.users
  end
end
