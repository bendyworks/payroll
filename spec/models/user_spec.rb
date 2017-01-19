# frozen_string_literal: true
require 'rails_helper'

describe User do
  describe '#pending?' do
    context 'user with invitation accepted timestamp' do
      let(:user) { create :user, :accepted_invitation }
      it 'returns false' do
        expect(user).to_not be_pending
      end
    end
    context 'user without invitation accepted timestamp' do
      context 'who has logged in' do
        let(:user) { create :user, :has_logged_in }
        it 'returns false' do
          expect(user).to_not be_pending
        end
      end
      context "who's never logged in" do
        let(:user) { create :user }
        it 'returns true' do
          expect(user).to be_pending
        end
      end
    end
  end
end
