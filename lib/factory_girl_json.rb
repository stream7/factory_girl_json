require 'factory_girl'
require 'fileutils'
require 'database_cleaner'
require 'factory_girl_json/factory_girl_ext/valid_options'
require 'factory_girl_json/version'
require 'factory_girl_json/exporter'
require 'factory_girl_json/railtie' if defined? Rails

module FactoryGirlJson
  class << self
    
    def export(factory_name)
      clean
      Exporter.new(factory_name).export
    end

    def export_all
      clean
      Exporter.new(:all).export
    end

    def export_serialized
      clean
      Exporter.new(:serialized).export
    end

    def clean
      DatabaseCleaner.clean_with :truncation
      DatabaseCleaner.clean
    end

  end
end
