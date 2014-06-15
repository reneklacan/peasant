module Peasant
  module NodeCallbacks
    def on_select_cb
      lambda do
        increment_counter
        on_select
      end
    end

    def on_connect_cb
      lambda { |node| on_connect }
    end

    def on_data_cb
      lambda { |data| on_data(data) }
    end

    def on_response_cb
      lambda { |node, response| on_response(response) }
    end

    def on_finish_cb
      lambda do |node|
        node.decrement_counter
        on_finish
      end
    end

    def on_select
    end

    def on_connect
    end

    def on_data data
      data
    end

    def on_response response
      response
    end

    def on_finish
    end

    def assign_callbacks_to connection
      connection.on_connect  &on_connect_cb
      connection.on_data     &on_data_cb
      connection.on_response &on_response_cb
      connection.on_finish   &on_finish_cb
    end
  end
end
