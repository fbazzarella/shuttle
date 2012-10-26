module Shuttle
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_install_file
        template 'shuttle.rb', 'config/initializers/shuttle.rb'
      end
    end
  end
end
