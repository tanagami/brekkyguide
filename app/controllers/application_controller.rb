class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

  def read(result)
    no = result['hotel'].first["hotelBasicInfo"]["hotelNo"]
    name = result['hotel'].first["hotelBasicInfo"]["hotelName"]
    information_url = result['hotel'].first["hotelBasicInfo"]["hotelInformationUrl"]
    kananame = result['hotel'].first["hotelBasicInfo"]["hotelKanaName"]
    min_charge = result['hotel'].first["hotelBasicInfo"]["hotelMinCharge"]
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
      no: no,
      name: name,
      information_url: information_url,
      kananame: kananame,
      min_charge: min_charge,
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
