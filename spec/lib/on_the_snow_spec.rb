require 'spec_helper'
require 'on_the_snow'

describe OnTheSnow do

  describe '.new' do
    it 'returns an OnTheSnow::Client' do
      OnTheSnow.new.should be_a OnTheSnow::Client
    end
  end

end
