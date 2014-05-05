require 'on_the_snow/core_ext/string'

class Hash

  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end

  def to_result!
    keys.each do |key|
      value = delete(key)
      self[key.to_s.underscore.to_sym] = case value
                                         when Array
                                           value.map { |v| v.respond_to?(:to_result!) ? v.to_result! : v }
                                         else
                                           if value.respond_to?(:to_result!)
                                             if value.has_key?('@nil')
                                               nil
                                             else
                                               value.to_result!
                                             end
                                           else
                                             value.respond_to?(:cast_boolean) ? value.cast_boolean : value
                                           end
                                         end
      end
    self
  end

  # File activesupport/lib/active_support/core_ext/hash/slice.rb
  def slice(*keys)
    keys = keys.map! { |key| convert_key(key) } if respond_to?(:convert_key)
    hash = self.class.new
    keys.each { |k| hash[k] = self[k] if has_key?(k) }
    hash
  end

end
