class EventsVolunteersController < ApplicationController

  def register
    @ticket_block = TicketBlock.find(params[:id])
    @event = @ticket_block.event
    @events_volunteer = EventsVolunteer.new(event_id: @event.id, ticket_block_id: @ticket_block.id, volunteer_id: current_user.id)
    respond_to do |format|
      if @events_volunteer.save
        format.html { redirect_to home_path, notice: 'Thanks for volunteering!' }
      else
        format.html { redirect_to @event, notice: 'Sorry, there was a problem with the system. Please try again later.' }
      end
    end
  end

  def unregister
    @ticket_block = TicketBlock.find(params[:id])
    @event = @ticket_block.event
    @events_volunteer = EventsVolunteer.where(:event_id => 41, :ticket_block_id => 1, :volunteer_id => 1).first
    respond_to do |format|
      if @events_volunteer.destroy
        format.html { redirect_to home_path, notice: 'You have been unregistered!' }
      else
        format.html { redirect_to @event, notice: 'Sorry, there was a problem with the system. Please try again later.' }
      end
    end
  end

end
