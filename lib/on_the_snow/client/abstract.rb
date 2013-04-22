module OnTheSnow
  class Client

    # Abstract class for all Client classes.
    #
    class Abstract

      attr_reader :client, :id

      def self.chainable_methods
        raise NotImplementedError
      end

      def initialize(client, resource_id)
        @client = client
        @id = resource_id

        self.class.chainable_methods.each do |method_name|
          self.class.define_method(method_name) do
            client.send("#{self.class.name.downcase.sub(/.+::(\w+)$/, '\1')}_#{method_name}", id)
          end
        end
      end

    end

  end
end
