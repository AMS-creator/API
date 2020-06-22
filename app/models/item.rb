# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :favorites
  belongs_to :user
  validates_presence_of :name, :description, :price, :contact
  validates_uniqueness_of :description
  mount_uploader :image, ImageUploader
end
