# Has face
A validator for active model to detect the presence of faces in image by
using the face.com API. The validator works by uploading images to
face.com and then checking to see if any faces were tagged in the photo.
It has been tested with carrierwave attachments but will work with any
attachment type that responds to a 'path' method.

## Requirements
- Rails 3.0 or greater
- An account for accessing the face.com API (They are free at the moment)

## Installation
Add has_face to your Gemfile and then run bundle

    gem 'has_face'

Once installed we need to add our face.com API details to an
initializer. Either run the generator:

    rails g has_face:install

This will create an initializer located at `config/initializers/has_face.rb`
which you can edit. Or you can just copy the snippet blow:

    # config/initializers/has_face.rb
    HasFace.configure do |config|
      config.api_key    = 'your face.com API key'
      config.api_secret = 'your face.com API secret'
    end

## Usage

Simply add a validation to the image you want to ensure has faces:

    class User < ActiveRecord::Base
      validates :avatar, :has_face => true
    end

## Skipping face validations for testing

Face validations can be turned off for testing by setting the
`enable_validation` config value to false, this is usally best done in
your test config.

    HasFace.enable_validation = false

### Contributing

Fork on GitHub and after you’ve committed tested patches, send a pull request.

To get tests running simply run `bundle install` and then `rspec spec`

For the tests to pass you'll need to enter a valid API key and
secret into the spec helper.
