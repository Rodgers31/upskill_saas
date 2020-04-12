class PagesController < ApplicationController
  # Git request( which is our homepage)
def home
  @basic_plan = Plan.find(1)
  @pro_plan = Plan.find(2)
end
  def about
  end
end    