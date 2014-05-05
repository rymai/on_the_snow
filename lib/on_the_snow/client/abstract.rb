module OnTheSnow
  class Client

    # Abstract class for all Client classes.
    #
    class Abstract

      attr_reader :id

      def self.chainable_methods
        raise NotImplementedError
      end

      def initialize(client, resource_id)
        @client = client
        @id = resource_id
      end

      def respond_to?(method, include_private = false)
        super || self.class.chainable_methods.include?(method.to_s)
      end

      def method_missing(method, *args, &block)
        if self.class.chainable_methods.include?(method.to_s)
          @client.send("_#{self.class.name.downcase.sub(/.+::(\w+)$/, '\1')}_#{method}", id)
        else
          super
        end
      end

    end

  end
end
