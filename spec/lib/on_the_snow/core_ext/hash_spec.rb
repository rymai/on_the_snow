require 'on_the_snow/core_ext/hash'

describe Hash do

  describe '#symbolize_keys!' do
    let(:hash) do
      { 'foo' => [{ 'bar' => 'n', 'rab' => [{ 'zab' => 'y' }], 'ofo' => 'bra' }] }
    end

    it 'symbolize all keys even inside nested arrays' do
      hash.symbolize_keys!

      hash.should eq({
        foo: [{ 'bar' => 'n', 'rab' => [{ 'zab' => 'y' }], 'ofo' => 'bra' }]
      })
    end
  end

  describe '#to_result!' do
    let(:hash) do
      { 'foo' => [{ 'bar' => 'n', 'rab' => [{ 'zab' => 'y' }], 'ofo' => 'bra' }] }
    end

    it 'symbolize all keys even inside nested arrays' do
      hash.to_result!

      hash.should eq({
        foo: [{ bar: false, rab: [{ zab: true }], ofo: 'bra' }]
      })
    end
  end

end
