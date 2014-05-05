require 'on_the_snow/core_ext/hash'

describe Hash do

  describe '#to_result!' do
    let(:hash) do
      { 'foo' => [{ 'bar' => 'n', 'rab' => [{ 'zab' => 'y' }], 'ofo' => 'bra', 'baz' => { '@nil' => 'true' } }] }
    end

    it 'symbolize all keys even inside nested arrays' do
      hash.to_result!

      hash.should eq({
        foo: [{ bar: false, rab: [{ zab: true }], ofo: 'bra', baz: nil }]
      })
    end
  end

end
