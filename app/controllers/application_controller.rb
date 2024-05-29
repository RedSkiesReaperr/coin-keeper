# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  private

  def after_sign_in_path_for(_user)
    dashboard_url
  end
end
