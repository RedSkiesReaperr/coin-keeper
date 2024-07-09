# frozen_string_literal: true

class UserPreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_preference, only: :update

  def update
    respond_to do |format|
      format.turbo_stream { flash[:alert] = update_error_message } unless @user_preference.update(update_params)

      format.turbo_stream
    end
  end

  private

  def update_params
    @update_params ||= params.require(:user_preference).permit(:start_date, :end_date)
  end

  def set_user_preference
    @user_preference = current_user.user_preference
  end

  def update_error_message
    return unless @user_preference.errors[:start_date].present? || @user_preference.errors[:end_date].present?

    I18n.t('user_preferences.update.invalid', from: update_params[:start_date], to: update_params[:end_date])
  end
end
