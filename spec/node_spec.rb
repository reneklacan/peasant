$:.push File.expand_path("../lib")

require './spec/spec_helper'
require 'peasant'

describe Peasant::Node do
  it 'should set default values' do
    host = 'example.com'
    port = '123'

    node = Peasant::Node.new(host: host, port: port)

    expect(node.load).to eq 0
    expect(node.host).to eq host
    expect(node.port).to eq port
  end
end
