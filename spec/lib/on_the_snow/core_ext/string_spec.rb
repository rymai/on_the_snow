require 'on_the_snow/core_ext/string'

describe String do

  describe '#cast_boolean' do
    let(:string)     { 'foo' }
    let(:string_yes) { 'y' }
    let(:string_no)  { 'n' }

    it 'leaves the string as it is if it is not y nor n' do
      string.cast_boolean.should eq 'foo'
    end

    it 'casts the string to true if it is y' do
      string_yes.cast_boolean.should eq true
    end

    it 'casts the string to true if it is n' do
      string_no.cast_boolean.should eq false
    end
  end

end
