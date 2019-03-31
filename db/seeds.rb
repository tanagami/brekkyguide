require 'net/http'

def read_middle(result)
  code = result["middleClass"].first["middleClassCode"]
  name = result["middleClass"].first["middleClassName"]
  {
    code: code,
    name: name,
  }
end

def read_small(result1, result2)
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

def read_detail(result1, result2, result3)
  code = result3["detailClass"]["detailClassCode"]
  name = result3["detailClass"]["detailClassName"]
  middlie_class_code = result1["middleClass"].first["middleClassCode"]
  middle_class = MiddleClass.find_by(code: middlie_class_code)      
  middle_class_id = middle_class.id
  small_class_name = result2["smallClass"].first["smallClassName"]
  small_class = SmallClass.find_by(name: small_class_name)
  small_class_id = small_class.id
  {
    code: code,
    name: name,
    middle_class_id: middle_class_id,
    small_class_id: small_class_id
  }
end

uri_base = "https://app.rakuten.co.jp/services/api/Travel/GetAreaClass/20131024?"
params_base = {
  format: 'json',
  applicationId: ENV['RAKUTEN_APPLICATION_ID']
}
uri = URI.parse(uri_base + params_base.to_param)

json = Net::HTTP.get(uri)
results_json = JSON.parse(json)
results = results_json["areaClasses"].first.second.first["largeClass"].second["middleClasses"]

results.each do |result|
  middle_class = MiddleClass.create!(read_middle(result))
end

results.each do |result1|
  result1["middleClass"].second["smallClasses"].each do |result2|
    small_class = SmallClass.create!(read_small(result1, result2))
  end
end

results.each do |result1|
  result1["middleClass"].second["smallClasses"].each do |result2|
    if result2["smallClass"].second.present? 
      result2["smallClass"].second["detailClasses"].each do |result3|
        detail_class = DetailClass.create!(read_detail(result1, result2, result3))
      end
    end
  end
end





