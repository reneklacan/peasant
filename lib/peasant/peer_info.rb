module Peasant
  class PeerInfo
    def initialize peer, args={}
      @peer = peer
      reset
      @max_requests = args[:max_requests] || 3
      @node_timeout = args[:node_timeout] || 15
    end

    def node
      node_expired? ? nil : @node
    end

    def node= n
      reset
      @node = n
      @node_expiration = Time.now.to_f + @node_timeout
    end

    def node_expired?
      expired = @node_expiration < Time.now.to_f || @requests > @max_requests
      reset if expired
      expired
    end

    def inc_requests
      @requests += 1
    end

    def reset_node_expiration
      @node_expiration = Time.now.to_f + @node_timeout
    end

    def reset
      @node = nil
      @requests = 0
      @node_expiration = 0
    end
  end
end
