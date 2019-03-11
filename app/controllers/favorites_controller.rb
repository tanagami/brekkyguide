class FavoritesController < ApplicationController
  def create
    @hotel = Hotel.find_or_initialize_by(no: params[:hotel_no])
    
    unless @hotel.persisted?
      uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?format=json&affiliateId=17e357ca.94ed3df2.17e357cb.ba7a82c9&responseType=large&hotelNo=#{@hotel.no}&applicationId=1029124388619924322")
      json = Net::HTTP.get(uri)
      results_json = JSON.parse(json)
      result = results_json["hotels"].first

      @hotel = Hotel.new(read(result))
      @hotel.save
    end
    
    current_user.like(@hotel)
    flash[:success] = 'ホテルをお気に入り登録しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @hotel = Hotel.find(params[:hotel_id])
    current_user.unlike(@hotel)
    flash[:success] = 'ホテルのお気に入り登録を解除しました'
    redirect_back(fallback_location: root_path)
  end
end
