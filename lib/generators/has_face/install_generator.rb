module HasFace
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy HasFace default files"
      source_root File.expand_path('../templates', __FILE__)
      class_option :template_engine

      def copy_initializers
        copy_file 'has_face.rb', 'config/initializers/has_face.rb'
      end

    end
  end
end

