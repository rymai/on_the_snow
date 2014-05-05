require 'spec_helper'

describe OnTheSnow::Faraday::Response::OnTheSnowResponseHandler do

  let(:middleware) { described_class.new }

  describe 'valid response' do
    let(:raw_body) { { "@type" => "ots.webservice.ski2009.ResortLite","elevation_base" => 1620 } }
    let(:env) { { status: 200, body: { "getResortInfoLiteResponse" => { 'return' => raw_body } } } }

    it 'select the body itself' do
      middleware.on_complete(env)

      expect(env[:status]).to eq 200
      expect(env[:body]).to eq raw_body
    end

    describe 'nil values' do
      let(:raw_body) { { "foo" => { '@nil' => 'true' } } }

      it 'cleans nil hash to "nil"' do
        middleware.on_complete(env)

        expect(env[:body][:foo]).to be_nil
      end
    end
  end

  # it happens sometimes...
  describe 'empty response' do
    let(:env) { { status: 200, body: { "getResortInfoLiteResponse" => '' } } }

    it 'select the body itself' do
      middleware.on_complete(env)

      expect(env[:status]).to eq 200
      expect(env[:body]).to eq []
    end
  end

  describe 'faulty response' do
    let(:raw_body) { "<soapenv:Fault xmlns:soapenv=\"http:\/\/www.w3.org\/2003\/05\/soap-envelope\"><soapenv:Code><soapenv:Value>soapenv:Receiver<\/soapenv:Value><\/soapenv:Code><soapenv:Reason><soapenv:Text xml:lang=\"en-US\">There was a problem processing your request.<\/soapenv:Text><\/soapenv:Reason><soapenv:Detail\/><\/soapenv:Fault>" }
    let(:env) { { status: 500, body: { "Fault" => raw_body } } }
    let(:final_body) { { error: raw_body } }

    it 'select the body itself' do
      middleware.on_complete(env)

      expect(env[:status]).to eq 500
      expect(env[:body]).to eq final_body
    end
  end

end
