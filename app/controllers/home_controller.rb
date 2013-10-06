class HomeController < ApplicationController
  # load_and_authorize_resource

  def index
    @user = User.new
    if current_user && current_user.attending_events?
      @local_events = Event.available_events(current_user).by_date.near(remote_ip).limit(4)
      @events = Event.available_events(current_user).by_date.limit(3)
      @user_events = current_user.events.by_date
    else
      @local_events = Event.by_date.near(remote_ip).limit(4)
      @events = Event.by_date.limit(3)
    end
  end

  def landing
  end

  def search
    @search_events = @q.result(distinct: true).page(params[:events_page]).per(6)
    @causes = Event.tag_counts_on(:causes)
  end

  def cause_cloud
    @causes = Event.tag_counts_on(:causes)
    respond_to do |format|
        format.json { render json: @causes, location: @causes }
    end
  end

end
