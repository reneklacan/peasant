module Peasant
  class Server
    include Singleton

    attr_reader :node_manager

    def self.run args={}
      instance.run(args)
    end

    def initialize
    end

    def run args={}
      raise 'You have to specify nodes' if args[:nodes].nil?

      @host = args[:host] || '127.0.0.1'
      @port = args[:port] || 9999
      @node_manager = NodeManager.new(args[:nodes].map{ |n| Node.new(n) })

      run_control_server
      run_main_server
    end

    protected

    def run_control_server
      @control_thread ||= Thread.new do
        EventMachine.run do
          Signal.trap('INT')  { EventMachine.stop }
          Signal.trap('TERM') { EventMachine.stop }

          puts "Launching control server..."
          EventMachine.start_server("0.0.0.0", 9998, Peasant::ControlServer)
        end
      end
    end

    def run_main_server
      puts "Launching proxy at #{@host}:#{@port}..."

      node_manager = @node_manager

      Proxy.start(host: @host, port: @port, debug: false) do |conn|
        node_manager.select_for(conn.peer) do |node|
          conn.server node,  host: node.host, port: node.port
          node.assign_callbacks_to(conn)
        end
      end

      @control_thread.join unless @control_thread.nil?
    end
  end
end
