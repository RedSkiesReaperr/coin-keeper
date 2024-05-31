# frozen_string_literal: true

class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    results = Movement.search(query: params[:query])
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

  private

  def filtering_params
    params.permit(:query, :pointed, :ignored)
  end
end
