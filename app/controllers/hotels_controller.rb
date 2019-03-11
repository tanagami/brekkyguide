class HotelsController < ApplicationController
  def new
    @hotels = []
    
    @largeclass = params[:largeclass]
    @middleclass = params[:middleclass]
    @smallclass = params[:smallclass]
    @detailclass = params[:detailclass]

    if @smallclass.present?
      uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&largeClassCode=#{@largeclass}&middleClassCode=#{@middleclass}&smallClassCode=#{@smallclass}&detailClassCode=#{@detailclass}&affiliateId=17e357ca.94ed3df2.17e357cb.ba7a82c9&responseType=large&applicationId=1029124388619924322")
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      results = results_json["hotels"]
      
      results.each do |result|
        hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
        unless hotel
          hotel = Hotel.new(read(result))
        end
        @hotels << hotel
      end
    end
    
    if params[:keyword].present?
      @keyword = URI.escape(params[:keyword])
      uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/KeywordHotelSearch/20170426?format=json&\keyword=#{@keyword}&responseType=large&affiliateId=17e357ca.94ed3df2.17e357cb.ba7a82c9&applicationId=1029124388619924322")
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      results = results_json["hotels"]
      
      results.each do |result|
        hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
        unless hotel
          hotel = Hotel.new(read(result))
        end
        @hotels << hotel
      end
    end
  end
  
  def show
    @hotel = Hotel.find(params[:id])
    @like_users = @hotel.users
  end
end
