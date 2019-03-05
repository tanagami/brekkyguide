class SmallClassesController < ApplicationController
  def new
    uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/GetAreaClass/20131024?format=json&applicationId=1029124388619924322")
    json = Net::HTTP.get(uri)
    results_json = JSON.parse(json)
    results = results_json["areaClasses"].first.second.first["largeClass"].second["middleClasses"]
    results.each do |result1|
        result1["middleClass"].second["smallClasses"].each do |result2|
        small_class = SmallClass.create(read(result1, result2))
      end
    end
  end
  
  private
  
  def read(result1, result2)
    code = result2["smallClass"].first["smallClassCode"]
    name = result2["smallClass"].first["smallClassName"]
    middlie_class_code = result1["middleClass"].first["middleClassCode"]
    middle_class = MiddleClass.find_by(code: middlie_class_code)      
    middle_class_id = middle_class.id
    {
      code: code,
      name: name,
      middle_class_id: middle_class_id
    }
  end
  
end
