class HotelsController < ApplicationController
  def new
    @hotels = []
    
    @largeclass_code = params[:largeclass]
    @middleclass_id = params[:middleclass]
    @smallclass_id = params[:smallclass]
    @detailclass_id = params[:detailclass]
    
    @middleclass = MiddleClass.find(@middleclass_id) if @middleclass_id
    @smallclass = SmallClass.find(@smallclass_id) if @smallclass_id
    if @detailclass_id.present?
      @detailclass_code = DetailClass.find(@detailclass_id).code
    else
      @detailclass_code = ""
    end
    
    @display_keyword = params[:keyword]

    # エリアから探す
    if @smallclass.present?
      uri_base = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?"
      params_base = {
        format: 'json',
        largeClassCode: @largeclass_code,
        middleClassCode: @middleclass.code,
        smallClassCode: @smallclass.code,
        detailClassCode: @detailclass_code,
        affiliateId: ENV['RAKUTEN_AFFILIATE_ID'],
        applicationId: ENV['RAKUTEN_APPLICATION_ID']
      }
      uri = URI.parse(uri_base + params_base.to_param)
      
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      results = results_json["hotels"]

      results.each do |result|
        hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
        unless hotel
          hotel = Hotel.new(read(result))
          hotel.meal_average = nil if hotel.meal_average == 0.0
        end
        @hotels << hotel if hotel.meal_average
        @hotels = @hotels.sort_by{|o| o.meal_average.to_f }.reverse
      end
    end
    
    # キーワードから探す
    if params[:keyword].present?
      @keyword = params[:keyword]
      uri_base = "https://app.rakuten.co.jp/services/api/Travel/KeywordHotelSearch/20170426?"
      params_base = {
        format: 'json',
        keyword: @keyword,
        affiliateId: ENV['RAKUTEN_AFFILIATE_ID'],
        applicationId: ENV['RAKUTEN_APPLICATION_ID']
      }
      uri = URI.parse(uri_base + params_base.to_param)
      
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      results = results_json["hotels"]
      
      results.each do |result|
        hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
        unless hotel
          hotel = Hotel.new(read(result))
          hotel.meal_average = nil if hotel.meal_average == 0.0
        end
        @hotels << hotel if hotel.meal_average
        @hotels = @hotels.sort_by{|o| o.meal_average.to_f }.reverse
      end
    end
    
    # ホテル詳細ページ
    if params[:hotel_no].present?
      @hotel_no = params[:hotel_no]
      uri_base = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?"
      params_base = {
        format: 'json',
        hotelNo: @hotel_no,
        affiliateId: ENV['RAKUTEN_AFFILIATE_ID'],
        applicationId: ENV['RAKUTEN_APPLICATION_ID']
      }
      uri = URI.parse(uri_base + params_base.to_param)
      
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      result = results_json["hotels"].first

      hotel = Hotel.find_by(no: result['hotel'].first["hotelBasicInfo"]["hotelNo"])
      unless hotel
        hotel = Hotel.new(read(result))
      end
      @hotel = hotel
    end
  end
end
