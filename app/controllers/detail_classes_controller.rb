class DetailClassesController < ApplicationController
  def new
    uri = URI.parse("https://app.rakuten.co.jp/services/api/Travel/GetAreaClass/20131024?format=json&applicationId=1029124388619924322")
    json = Net::HTTP.get(uri)
    results_json = JSON.parse(json)
    results = results_json["areaClasses"].first.second.first["largeClass"].second["middleClasses"]
    results.each do |result1|
      result1["middleClass"].second["smallClasses"].each do |result2|
        if result2["smallClass"].second.present? 
          result2["smallClass"].second["detailClasses"].each do |result3|
            detail_class = DetailClass.create(read(result1, result2, result3))
          end
        end
      end
    end
  end
    
  private
  
  def read(result1, result2, result3)
    code = result3["detailClass"]["detailClassCode"]
    name = result3["detailClass"]["detailClassName"]
    middlie_class_code = result1["middleClass"].first["middleClassCode"]
    middle_class = MiddleClass.find_by(code: middlie_class_code)      
    middle_class_id = middle_class.id
    small_class_code = result2["smallClass"].first["smallClassCode"]
    small_class = SmallClass.find_by(code: small_class_code)
    small_class_id = small_class.id
    {
      code: code,
      name: name,
      middle_class_id: middle_class_id,
      small_class_id: small_class_id
    }
  end
  
end
