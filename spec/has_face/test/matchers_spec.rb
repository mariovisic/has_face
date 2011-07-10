require 'spec_helper'

describe HasFace::Test::Matchers do

  context 'a user without face valdiation' do

    subject { UserWithoutFaceValidation.new }

    it { should_not validate_has_face_for :avatar }

  end

  context 'a user with face validation' do

    subject { UserWithFaceValidation.new }

    it { should validate_has_face_for :avatar }

  end

end
