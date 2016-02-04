class ReservationsController < ApplicationController

  before_action :load_reservation, only: [:show, :edit, :update, :destroy]
  before_action :load_user

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user = current_user

    if @restaurant.available?(@reservation.party_size, @reservation.date_time)
      @reservation.save
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @reservation.update_attributes(reservation_params)
      redirect_to restaurants_path
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to restaurants_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date_time, :party_size)
  end

  def load_reservation
    @reservation = Reservation.find(params[:id])
  end

  def load_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @user = current_user
  end

end
