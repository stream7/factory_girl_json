module FactoryGirlJson
  class Exporter
    def initialize(factories)
      @factories = find_factories(factories)
      $stdout.puts "Exporting factories: #{@factories.map(&:name)}"
    end

    def export
      @factories.each do |factory|
        export_factory(factory)
      end
    end

    def export_factory(factory)
      $stdout.puts "Exporting factory #{factory.name}"
      path = file_path(factory)
      unless File.exists? path
        model = factory.run(:create, {})
        json = to_json(model, factory.json_serializer)
        write_file(json, path)
      else
        $stderr.puts "File #{factory.name}.json exists, delete file and run again to rewrite"
      end
    end

    def to_json(model, serializer = nil)
      if serializer
        serializer.new(model).to_json
      else
        model.to_json
      end
    end

    def write_file(json, path)
      FileUtils.mkdir_p File.dirname(path)
      File.open(path, 'w') do |file|  
        file.puts JSON.pretty_generate(JSON.parse(json))
      end
      $stdout.puts "Wrote file #{path}"
    end

    def file_path(factory)
      if defined? Rails
        if Dir.exists? Rails.root.join('spec').to_s
          Rails.root.join("spec/javascripts/fixtures/json/#{factory.name}.json").to_s
        elsif Dir.exists? Rails.root.join('test').to_s
          Rails.root.join("test/javascripts/fixtures/json/#{factory.name}.json").to_s
        else
          "#{Dir.pwd}/#{factory.name}.json"  
        end
      else
        "#{Dir.pwd}/#{factory.name}.json"
      end
    end

    private 

    def find_factories(factories)
      case factories
      when :all
        FactoryGirl.factories.to_a
      when :serialized
        FactoryGirl.factories.to_a.select { |f| f.json_serializer }
      else
        if factories.is_a? Array
          FactoryGirl.factories.to_a.select { |f| factories.include? f.name.to_s }
        else
          [FactoryGirl.factories.find(factories.to_sym)]
        end
      end
    end
  end
end