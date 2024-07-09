# frozen_string_literal: true

class MovementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movement, only: %i[show edit update]

  def index
    @movements_count = filtered_movements.count
    @total_amount = filtered_movements.sum(:amount)
    @pagy, @movements = pagy(filtered_movements.order(date: :asc, label: :asc))

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show; end

  def edit; end

  def create
    attach = current_user.import_files.attach(params[:file])
    ImportMovementsJob.perform_later(attachment_id: attach.last.id, user: current_user)
  end

  def update
    if @movement.update(update_params)
      respond_to do |format|
        format.html { redirect_to movements_path, notice: I18n.t('movements.update.success') }
        format.turbo_stream { flash.now[:notice] = I18n.t('movements.update.success') }
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
    params.permit(:format, :query, :pointed, :ignored)
  end

  def update_params
    params.require(:movement).permit(:label, :comment, :pointed, :ignored)
  end

  def target_period
    @target_period ||= current_user.user_preference.dates_range
  end

  def movements
    @movements ||= current_user.movements.within_date_range(target_period)
  end

  def filtered_movements
    @filtered_movements ||= begin
      results = movements
      results = results.search(filtering_params[:query]) if filtering_params[:query].present?
      results = results.pointed(filtering_params[:pointed]) if filtering_params[:pointed].present?
      results = results.ignored(filtering_params[:ignored]) if filtering_params[:ignored].present?
      results
    end
  end
end
