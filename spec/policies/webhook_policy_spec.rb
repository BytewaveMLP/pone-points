# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:webhook) { build(:webhook) }
  let(:pone) { webhook.pone }
  let(:other_pone) { build(:pone) }

  permissions :index?, :create? do
    it 'does not permit guests' do
      expect(policy).not_to permit(nil, Webhook)
    end

    it 'permits authenticated pones' do
      expect(policy).to permit(pone, Webhook)
    end
  end

  permissions :show?, :regenerate?, :destroy? do
    it 'does not permit guests' do
      expect(policy).not_to permit(nil, webhook)
    end

    it 'permits the owner of the webhook' do
      expect(policy).to permit(pone, webhook)
    end

    it 'does not permit other pones' do
      expect(policy).not_to permit(other_pone, webhook)
    end
  end
end
