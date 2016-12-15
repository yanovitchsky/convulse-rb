require 'spec_helper'
require 'timecop'


describe Convulse do

  it 'queries service' do
    status, res = Convulse.discover(:sap_bridge)
    expect(status).to eq(:ok)
    expect(res.size).to eq(1)
    expect(res.first).to have_key(:service_name)
    expect(res.first).to have_key(:address)
    expect(res.first).to have_key(:port)
  end

  it 'returns error with unknown service name' do
    status, res = Convulse.discover(:plop)
    expect(status).to eq(:error)
    expect(res).to eq(:unknown_service)
  end

  it 'caches response' do
    allow(HTTParty).to receive(:get).and_call_original
    status, res = Convulse.discover(:sap_bridge)
    expect(res.first[:service_name]).to eq("sap_bridge")
    Timecop.freeze(Time.now + 10)
    status, res = Convulse.discover(:sap_bridge)
    expect(res.first[:service_name]).to eq("sap_bridge")
    expect(HTTParty).to have_received(:get).once
  end

  # it 'does not cache if first call is error' do
  #   # Convulse.discover(p)
  # end
  #
  # it 'cleans cache after defined ttl' do
  #   # pending("later")
  # end
end
