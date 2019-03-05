class MiddleClassesController < ApplicationController

  def new
    uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/GetAreaClass/20131024?format=json&applicationId=1029124388619924322")
    json = Net::HTTP.get(uri)
    results_json = JSON.parse(json)
    results = results_json["areaClasses"].first.second.first["largeClass"].second["middleClasses"]
    results.each do |result|
      middle_class = MiddleClass.create(read(result))
    end
  
  end
    
  private
  
  def read(result)
    code = result["middleClass"].first["middleClassCode"]
    name = result["middleClass"].first["middleClassName"]
    {
      code: code,
      name: name,
    }
  end
end