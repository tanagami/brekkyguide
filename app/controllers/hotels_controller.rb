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
        hotel = Hotel.new(read(result))
        @hotels << hotel
      end
    end

  end
  
  private
  
  def read(result)
    name = result['hotel'].first["hotelBasicInfo"]["hotelName"]
    kananame = result['hotel'].first["hotelBasicInfo"]["hotelKanaName"]
    special = result['hotel'].first["hotelBasicInfo"]["hotelSpecial"]
    address1 = result['hotel'].first["hotelBasicInfo"]["address1"]
    address2 = result['hotel'].first["hotelBasicInfo"]["address2"]
    access = result['hotel'].first["hotelBasicInfo"]["access"]
    image_url = result['hotel'].first["hotelBasicInfo"]["hotelImageUrl"]
    thumbnail_url = result['hotel'].first["hotelBasicInfo"]["hotelThumbnailUrl"]
    review_count = result['hotel'].first["hotelBasicInfo"]["reviewCount"]
    review_average = result['hotel'].first["hotelBasicInfo"]["reviewAverage"]
    meal_average = result['hotel'].second["hotelRatingInfo"]["mealAverage"]
    {
      name: name,
      kananame: kananame,
      special: special,
      address1: address1,
      address2: address2,
      access: access,
      image_url: image_url,
      thumbnail_url: thumbnail_url,
      review_count: review_count,
      review_average: review_average,
      meal_average: meal_average,
    }
  end
end
