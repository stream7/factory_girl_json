module FactoryGirl
  class Factory
    attr_reader :json_serializer

    private

    def assert_valid_options(options)
      options.assert_valid_keys(:class, :parent, :aliases, :traits, :json_serializer)
      @json_serializer = options[:json_serializer]
    end
  end
end