class CommunitiesController < ApplicationController

  def index
    @communities = Community.all
    @next_event = Event.all.sort {|a,b| a.start_time <=> b.start_time}.last
  end

  def show
    @community = Community.find(params[:id])
  end

end
