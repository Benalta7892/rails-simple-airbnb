# frozen_string_literal: true

# Flat controller
class FlatsController < ApplicationController
  before_action :set_flat, only: %i[show edit update destroy]

  def index
    @flats = Flat.all
  end

  def search
    @flats = Flat.all
    @search_flats = Flat.where('name LIKE?', "%#{params[:search]}%")
  end

  def show; end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)

    if @flat.save
      redirect_to @flat, notice: 'Flat was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update

    if @flat.update(flat_params)
      redirect_to @flat, notice: 'Flat was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path, notice: 'Flat was successfully destroyed.', status: :see_other
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :picture_url, :description, :price_per_night, :number_of_guests)
  end
end
