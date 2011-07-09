require 'spec_helper'

describe HasFace::Validator do

  let(:user)   { User.new(:avatar => avatar) }
  let(:avatar) { Avatar.new }

  context 'when validation is globally turned on' do

    context 'when the image is a valid face' do

      before :each do
        avatar.path = VALID_IMAGE_PATH
      end

      it 'should be valid' do
        user.should be_valid
      end

    end

    context 'when the image is not a valid face' do

      before :each do
        avatar.path = INVALID_IMAGE_PATH
      end

      it 'should not be valid' do
        user.should_not be_valid
      end

      it 'should have an error on the image field' do
        user.valid?
        user.errors[:avatar].should == [ "We couldn't see a face in your photo, try taking another one." ]
      end

    end

  end

  context 'when face validation is globally turned off' do

    before :each do
      HasFace.enable_validation = false
      avatar.path = INVALID_IMAGE_PATH
    end

    after :each do
      HasFace.enable_validation = true
    end

    it 'should be valid' do
      user.should be_valid
    end

  end

  context 'allowing blank' do

    context 'when allow blank is true' do

      class UserWithAllowBlank < BaseUser
        validates :avatar, :has_face => true, :allow_blank => true
      end

      let(:user) { UserWithAllowBlank.new }

      before :each do
        stub(user).avatar { "" }
      end

      it 'should be valid with a blank avatar' do
        user.should be_valid
      end

    end

    context 'when allow blank is not true' do

      class UserWithoutAllowBlank < BaseUser
        validates :avatar, :has_face => true, :allow_blank => false
      end

      let(:user) { UserWithoutAllowBlank.new }

      before :each do
        stub(user).avatar { "" }
      end

      it 'should not be valid' do
        user.should_not be_valid
      end

    end

  end

  context 'allowing nil' do

    context 'when allow nil is true' do

      class UserWithAllowNil < BaseUser
        validates :avatar, :has_face => true, :allow_nil => true
      end

      let(:user) { UserWithAllowNil.new }

      before :each do
        stub(user).avatar { nil }
      end

      it 'should be valid with a nil avatar' do
        user.should be_valid
      end

    end

    context 'when allow nil is not true' do

      class UserWithoutAllowNil < BaseUser
        validates :avatar, :has_face => true, :allow_nil => false
      end

      let(:user) { UserWithoutAllowNil.new }

      before :each do
        stub(user).avatar { nil }
      end

      it 'should not be valid' do
        user.should_not be_valid
      end

    end

  end

end
