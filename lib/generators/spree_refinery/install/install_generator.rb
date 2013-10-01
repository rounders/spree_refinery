module SpreeRefinery
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false
        
      def installing_refinery
        run 'bundle exec rails generate refinery:cms --fresh-installation --skip-db'
      end
    end
  end
end
