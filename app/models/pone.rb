# frozen_string_literal: true

# == Schema Information
#
# Table name: pones
#
#  id           :bigint           not null, primary key
#  name         :citext           not null
#  discord_id   :string           not null
#  points_count :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_pones_on_discord_id  (discord_id) UNIQUE
#  index_pones_on_name        (name) UNIQUE
#
class Pone < ApplicationRecord
  has_many :boons, -> { order(occurred_at: :desc, id: :desc) }, dependent: :destroy, inverse_of: :pone

  validates :name, :discord_id, presence: true, length: { maximum: 50 }
end