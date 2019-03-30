class AreasController < ApplicationController
  def middle_classes
    @middle_classes = MiddleClass.where(id: params[:min]..params[:max])
    # 甲信越
    @middle_classes = MiddleClass.where(id: params[:id]) if params[:id]
  end
  
  def small_classes
    @middle_class = MiddleClass.find(params[:id])
    @small_classes = SmallClass.where(middle_class_id: params[:id])
  end
  
  def detail_classes
    @small_class = SmallClass.find(params[:id])
    @middle_class = MiddleClass.find(@small_class.middle_class_id)
    @detail_classes = DetailClass.where(small_class_id: params[:id])
  end
end
