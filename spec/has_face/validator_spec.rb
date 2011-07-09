require 'spec_helper'

describe HasFace::Validator do

  let(:user)   { User.new }
  let(:avatar) { user.image }

  context 'when validation is globally turned on' do

    before :all do
      HasFace.enable_validation = false
    end

    after :all do
      HasFace.enable_validation = true
    end

    context 'when the image is a valid face' do

      before :each do
        stub(avatar).url = HasFace::Spec::INVALID_IMAGE_URL
      end

      it 'should be valid' do
        debugger
        user.should be_valid
      end

    end

    context 'when the image is not a valid face' do

      before :each do

      end

      it 'should not be valid' do

      end

      it 'should have an error on the image field' do

      end

    end

  end

  context 'when face validation is globally turned off' do


  end

end 
