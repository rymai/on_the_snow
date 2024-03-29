class String

  def underscore
    word = self.to_s.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  def camelize
    string = self.to_s.dup
    string = string.sub(/^[a-z\d]*/) { $&.capitalize }
    string.gsub(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
  end

  def cast_boolean
    case self.to_s
    when 'y'
      true
    when 'n'
      false
    else
      self.to_s
    end
  end

end

class Symbol

  def camelize
    self.to_s.camelize
  end

end
