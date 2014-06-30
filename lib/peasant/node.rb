module Peasant
  class Node
    include NodeCallbacks

    attr_reader :host, :port
    attr_accessor :load

    def initialize options={}
      @load = 0
      @host, @port = options[:host], options[:port]
    end

    def increment_counter
      self.load += 1
    end

    def decrement_counter
      self.load -= 1
    end

    def to_s
      "#{host}:#{port}"
    end
  end
end
