module SpreeFilterGrid
   module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_filter_grid\n"
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/input-slider\n"
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/content-filter\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_filter_grid\n", :before => /\*\//, :verbose => true
      end

      def copy_ckeditor_files
        copy_file "lib/product_filters.rb", "lib/product_filters.rb"
      end

      def add_require
        inject_into_file 'config/initializers/spree.rb', " require 'product_filters'\n", :before => "Spree.config do |config|\n"
      end
    end
  end
end