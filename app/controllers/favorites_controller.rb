class FavoritesController < ApplicationController
  def create
    @hotel = Hotel.find_or_initialize_by(no: params[:hotel_no])
    
    unless @hotel.persisted?
      uri_base = "https://app.rakuten.co.jp/services/api/Travel/SimpleHotelSearch/20170426?"
      params_base = {
        format: 'json',
        hotelNo: @hotel.no,
        affiliateId: ENV['RAKUTEN_AFFILIATE_ID'],
        applicationId: ENV['RAKUTEN_APPLICATION_ID']
      }
      uri = URI.parse(uri_base + params_base.to_param)
      
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
