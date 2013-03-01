module Kimaya
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy Kimaya default files"
      source_root File.expand_path('../templates', __FILE__)

      def copy_config
        directory 'config/locales'
      end
    end
  end
end
