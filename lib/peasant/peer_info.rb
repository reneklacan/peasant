module Peasant
  class PeerInfo
    def initialize peer, args={}
      @peer = peer
      @node = nil
      @requests = 0
      @node_expiration = 0

      @max_requests = args[:max_requests] || 3
      @node_timeout = args[:node_timeout] || 15
    end

    def node
      node_expired? ? nil : @node
    end

    def node= n
      @node = n
      @node_expiration = Time.now.to_f + @node_timeout
      @requests = 0
    end

    def node_expired?
      @node_expiration < Time.now.to_f || @requests > @max_requests
    end

    def inc_requests
      @requests += 1
    end

    def reset_node_expiration
      @node_expiration = Time.now.to_f + @node_timeout
    end
  end
end
