# frozen_string_literal: true

# == Schema Information
#
# Table name: pones
#
#  id                  :bigint           not null, primary key
#  name                :citext           not null
#  slug                :string           not null
#  points_count        :integer          default(0), not null
#  daily_points_budget :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_pones_on_name  (name) UNIQUE
#  index_pones_on_slug  (slug) UNIQUE
#
class Pone < ApplicationRecord
  has_many :credentials, class_name: 'PoneCredential', dependent: :destroy, inverse_of: :pone

  has_many :boons, -> { order(created_at: :desc, id: :desc) }, dependent: :destroy, inverse_of: :pone
  has_many :granted_boons, class_name: 'Boon', dependent: :restrict_with_error, inverse_of: :granted_by

  validates :name, presence: true, length: { maximum: 50 }
  validates :daily_points_budget, numericality: { greater_than_or_equal_to: 0 }

  before_save :set_slug_from_name, if: :name_changed?

private

  # @return [void]
  def set_slug_from_name
    self.slug = name.parameterize
  end
end
