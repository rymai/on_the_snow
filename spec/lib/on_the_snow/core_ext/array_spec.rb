require 'on_the_snow/core_ext/array'

describe Array do

  describe '#to_result!' do
    let(:array) do
      [{ 'foo' => [{ 'bar' => 'n', 'rab' => [{ 'zab' => 'y' }], 'ofo' => 'bra' }] }]
    end

    it 'symbolize all keys for nested hashes' do
      array.to_result!

      array.should eq [{ foo: [{ bar: false, rab: [{ zab: true }], ofo: 'bra' }] }]
    end
  end

end
