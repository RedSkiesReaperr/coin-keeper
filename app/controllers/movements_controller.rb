# frozen_string_literal: true

class MovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @movements = Movement.all
  end
end
