module FactoryGirl
  class Factory
    attr_reader :json_serializer, :array_serializer, :json_items

    private

    def assert_valid_options(options)
      options.assert_valid_keys(:class, :parent, :aliases, :traits, :json_serializer, :array_serializer, :json_items)
      @json_serializer  = options[:json_serializer]
      @array_serializer = options[:array_serializer]
      @json_items       = options[:json_items]
    end
  end
end