# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }
  subject { user }

  describe 'instance attributes' do
    describe 'email' do
      context 'when nil' do
        before { subject.email = nil }

        it { is_expected.to be_invalid }
      end

      context 'when an empty string' do
        before { subject.email = '' }

        it { is_expected.to be_invalid }
      end

      context 'when already in use' do
        context 'and same case' do
          before { create :user, email: subject.email }

          it { is_expected.to be_invalid }
        end

        context 'and different case' do
          before { create :user, email: subject.email.swapcase }

          it { is_expected.to be_invalid }
        end
      end
    end

    describe 'first_name' do
      context 'when nil' do
        before { subject.first_name = nil }

        it { is_expected.to be_invalid }
      end

      context 'when an empty string' do
        before { subject.first_name = '' }

        it { is_expected.to be_invalid }
      end
    end

    describe 'last_name' do
      context 'when nil' do
        before { subject.last_name = nil }

        it { is_expected.to be_invalid }
      end

      context 'when an empty string' do
        before { subject.last_name = '' }

        it { is_expected.to be_invalid }
      end
    end
  end

  describe 'instance methods' do
    it { is_expected.to respond_to :full_name }

    describe '#full_name' do
      data = [
        {
          full_name: 'Bill Preston',
          user:      FactoryBot.build(:user, first_name: 'Bill', last_name: 'Preston')
        },
        {
          full_name: 'Ted Logan',
          user:      FactoryBot.build(:user, first_name: 'Ted', last_name: 'Logan')
        }
      ]

      data.each do |datum|
        context "when @first_name is '#{datum[:user].first_name}' and @last_name is '#{datum[:user].last_name}'" do
          it "returns '#{datum[:full_name]}'" do
            expect(datum[:user].full_name).to eq(datum[:full_name])
          end
        end
      end
    end
  end
end
