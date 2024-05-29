# frozen_string_literal: true

class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @movements = pagy(Movement.all)
  end
end
