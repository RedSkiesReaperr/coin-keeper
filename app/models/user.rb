# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_preference, dependent: :destroy
  has_many :movements, dependent: :destroy
  has_many_attached :import_files

  after_create :create_user_preference

  private

  def create_user_preference
    UserPreference.create!(user: self)
  end
end
