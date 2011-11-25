class CommunitiesController < ApplicationController

  def index
    if params[:q]
      @communities = Community.near(params[:q], 150)
    elsif params[:nearby]
      @communities = Community.near(request.location, 150)
    else
      @communities = Community.all
    end
    @next_event = Event.all.sort {|a,b| b.start_time <=> a.start_time}.last
  end

  def show
    @community = Community.find(params[:id])
  end

end
