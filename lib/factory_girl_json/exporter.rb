module FactoryGirlJson
  class Exporter
    def initialize(factory, size,  serializer)
      @factory = FactoryGirl.factories.find(factory.to_sym)
      @size = size ? size.to_i : 1
      @serializer = serializer.constantize if serializer
    end

    def export
      $stdout.puts "Exporting factory #{@factory.name}"
      path = file_path
      unless File.exists? path
        model_or_collection = if @size > 1
                                FactoryGirl.create_list(@factory.name.to_sym, @size)
                              else
                                @factory.run(:create, {})
                              end

        json = to_json(model_or_collection)
        write_file(json, path)
      else
        $stderr.puts "File #{file_name} exists, delete file and run again to rewrite"
      end
    end

    private

      def to_json(model_or_collection)
        if @serializer
          @serializer.new(model_or_collection).to_json
        else
          model_or_collection.to_json
        end
      end

      def write_file(json, path)
        FileUtils.mkdir_p File.dirname(path)
        File.open(path, 'w') do |file|  
          file.puts JSON.pretty_generate(JSON.parse(json))
        end
        $stdout.puts "Wrote file #{path}"
      end

      def file_path
        if defined? Rails
          if Dir.exists? Rails.root.join('spec').to_s
            Rails.root.join("spec/javascripts/fixtures/json/#{file_name}").to_s
          elsif Dir.exists? Rails.root.join('test').to_s
            Rails.root.join("test/javascripts/fixtures/json/#{file_name}").to_s
          else
            "#{Dir.pwd}/#{file_name}"  
          end
        else
          "#{Dir.pwd}/#{file_name}"
        end
      end

      def file_name
        name = ''
        name << "#{@size}." if @size > 1
        name << "#{@factory.name}"
        name << ".#{@serializer.to_s.underscore}".gsub('/','_') if @serializer
        name << '.json'
        name
      end
  end
end