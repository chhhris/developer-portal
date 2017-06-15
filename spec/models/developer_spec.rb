require 'spec_helper'

RSpec.describe Developer, type: :model do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_hash) }

  context 'validates format of' do
    let(:developer) { FactoryGirl.build(:developer) }
    subject { developer }

    describe 'username' do
      before do
        developer.email = 'mash@ape.ai'
        developer.password_hash = 'hmac2020'
      end

      it { should allow_value('foo-123').for(:username) }
      it { should allow_value('foo.bar').for(:username) }
      it { should allow_value('12345').for(:username) }
      it { should allow_value('foo_bar.co').for(:username) }
      it { should_not allow_values(['foo!', 'foo 1', 'foo%bar', 'foo&bar']).for(:username) }
    end

    describe 'email' do
      before do
        developer.username = 'mash-ape'
        developer.password_hash = 'hmac2020'
      end

      it { should allow_value('email@example.co').for(:email) }
      it { should allow_value('foo@bar.baz.com').for(:email) }
      it { should allow_value('12345@ml.ai').for(:email) }
      it { should allow_value('AbCdE@kitchen.co').for(:email) }
      it { should_not allow_values(['foo_1@', '@foo.com', 'foo [at] gnc.com', 'foo&bar@xyz.com']).for(:email) }
    end
  end

  context '#before_create' do
    let(:developer) { FactoryGirl.build(:developer) }

    it 'generates an authentication token' do
      expect(developer.authentication_token).to be_nil
      developer.save
      developer.reload
      expect(developer.authentication_token).to_not be_nil
    end
  end

end

