module Peasant
  class ControlServer < EM::Connection
    def receive_data data
      data = data.strip
      command, arg = data.split(' ', 2)

      case command
      when 'strategy'
        Peasant::Server.instance.strategy = arg.to_sym
      when 'next'
        Peasant::Server.instance.node_manager.shift_pool
      when 'exit'
        EventMachine.stop
      when 'node_count'
        send_data Peasant::Server.instance.node_manager.count
      else
        send_data 'invalid command'
      end
    end
  end
end
