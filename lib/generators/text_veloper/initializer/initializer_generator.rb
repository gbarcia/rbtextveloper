module TextVeloper
  module Generators
    class InitializerGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_initializer
        copy_file "text_veloper.rb", "config/initializers/text_veloper.rb"
      end
    end
  end
end