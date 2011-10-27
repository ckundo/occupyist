class CommunitiesController < ApplicationController

  def index
    @communities = Community.all
    @next_event = Event.all.sort {|a,b| b.start_time <=> a.start_time}.last
  end

  def show
    @community = Community.find(params[:id])
  end

end
