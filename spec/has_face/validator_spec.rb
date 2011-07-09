require 'spec_helper'

describe HasFace::Validator do

  let(:user)   { User.new }
  let(:avatar) { user.avatar }

  context 'when validation is globally turned on' do

    context 'when the image is a valid face' do

      before :each do
        stub(avatar).url = VALID_IMAGE_URL
      end

      it 'should be valid' do
        user.should be_valid
      end

    end

    context 'when the image is not a valid face' do

      before :each do
        stub(avatar).url = INVALID_IMAGE_URL
      end

      it 'should not be valid' do
        user.should_not be_valid
      end

      it 'should have an error on the image field' do
        user.valid?
        user.errors[:avatar].should == "We couldn't see a face in your photo, try taking another one."
      end

    end

  end

  context 'when face validation is globally turned off' do

    before :each do
      HasFace.enable_validation = false
      stub(avatar).url = INVALID_IMAGE_URL
    end

    after :each do
      HasFace.enable_validation = true
    end

    it 'should be valid' do
      user.should be_valid
    end

  end

end
