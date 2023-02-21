class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @events = Event.order(start_date: :desc)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(
      title: params[:event][:title],
      description: params[:event][:description],
      location: params[:event][:location],
      start_date: params[:event][:start_date],
      duration: params[:event][:duration],
      price: params[:event][:price],
      administrator: current_user
    )

    if @event.save
      flash[:success] = "Ton event est bien enregistré"
      redirect_to events_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @event.update(
      title: params[:event][:title],
      description: params[:event][:description],
      location: params[:event][:location],
      start_date: params[:event][:start_date],
      duration: params[:event][:duration],
      price: params[:event][:price]
    )

    if @event.save
      flash[:success] = "Ton event est bien mis à jour"
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Ton event a bien été supprimé"
    redirect_to(events_path)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end