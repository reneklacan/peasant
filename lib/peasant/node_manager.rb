module Peasant
  class NodeManager
    include Enumerable

    attr_accessor :strategy, :nodes

    def initialize nodes
      @nodes = nodes
      @pool = @nodes.clone
      @peers = {}
      @strategy = :roundrobin
    end

    def select
      @pool = @nodes.clone if @pool.empty?

      case @strategy
      when :balanced
        node = @nodes.sort_by{ |b| b.load }.first
      when :roundrobin
        node = @pool.shift
      when :random
        node = @nodes.sample
      when :manual
        node = @pool.first
      else
        raise ArgumentError, "Unknown strategy: #{@strategy}"
      end

      node.on_select_cb.call
      yield node if block_given?
      node
    end

    def select_for peer
      peer_info = @peers[peer] ||= PeerInfo.new(peer)
      node = peer_info.node ||= select
      peer_info.inc_requests
      peer_info.reset_node_expiration
      yield node if block_given?
      node
    end

    def shift_pool
      @pool = @nodes.clone if @pool.empty?
      @pool.shift
    end

    def each &block
      @nodes.each do |node|
        block.call(node)
      end
    end
  end
end
