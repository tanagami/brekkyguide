class ToppagesController < ApplicationController
  def index
    @middle_classes = MiddleClass.all
  end
end