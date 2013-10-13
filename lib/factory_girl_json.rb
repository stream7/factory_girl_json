require 'factory_girl'
require 'fileutils'
require 'database_cleaner'
require 'active_support/core_ext/string/inflections'
require 'factory_girl_json/version'
require 'factory_girl_json/exporter'
require 'factory_girl_json/railtie' if defined? Rails

module FactoryGirlJson
  class << self
    
    def export(factory_name, size = nil, serializer = nil)
      clean
      Exporter.new(factory_name, size, serializer).export
    end

    def clean
      DatabaseCleaner.clean_with :truncation
      DatabaseCleaner.clean
    end
  end
end
