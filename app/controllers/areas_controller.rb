class AreasController < ApplicationController
  def show_middle
    @middle_classes = MiddleClass.all.where(id: params[:min]..params[:max])
  end
  
  def show_small
    @small_classes = SmallClass.all.where(middle_class_id: params[:id])
  end
  
  def show_detail
    @detail_classes = DetailClass.all.where(small_class_id: params[:id])
  end
end
