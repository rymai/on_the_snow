require 'on_the_snow/core_ext/string'

class Hash

  def symbolize_keys!
    keys.each do |key|
      value = delete(key)
      self[key.to_sym] = value.respond_to?(:symbolize_keys!) ? value.symbolize_keys! : value
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
                                             value.to_result!
                                          else
                                            value.respond_to?(:cast_boolean) ? value.cast_boolean : value
                                          end
                                         end
      end
    self
  end

  def to_api!
    keys.each do |key|
      value = delete(key)
      self[key.to_s.camelize] = value.respond_to?(:to_api!) ? value.to_api! : value
    end
    self
  end

end
