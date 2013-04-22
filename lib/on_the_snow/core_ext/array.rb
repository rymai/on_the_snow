require 'on_the_snow/core_ext/hash'

class Array

  def to_result!
    each_with_index do |value, i|
      self[i] = value.respond_to?(:to_result!) ? value.to_result! : value
    end
    self
  end

end
