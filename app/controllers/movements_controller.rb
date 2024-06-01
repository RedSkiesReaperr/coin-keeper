# frozen_string_literal: true

class MovementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movement, only: %i[show edit update]

  def index
    results = current_user.movements.search(query: params[:query]).order(date: :asc, label: :asc)
    results = results.pointed(params[:pointed]) if params[:pointed].present?
    results = results.ignored(params[:ignored]) if params[:ignored].present?

    @movements_count = results.count
    @total_amount = results.sum(:amount)
    @pagy, @movements = pagy(results)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show; end

  def edit; end

  def update
    if @movement.update(update_params)
      respond_to do |format|
        format.html { redirect_to movements_path, notice: 'Movement was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Movement was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_movement
    @movement = current_user.movements.find(params[:id])
  end

  def filtering_params
    params.permit(:query, :pointed, :ignored)
  end

  def update_params
    params.require(:movement).permit(:label, :comment, :pointed, :ignored)
  end
end
