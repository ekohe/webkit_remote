module WebkitRemote

class Client

# API for the Console domain.
module Console
  # Enables or disables the generation of events in the Console domain.
  #
  # @param [Boolean] new_console_events if true, the browser debugger will
  #     generate Console.* events
  def console_events=(new_console_events)
    new_console_events = !!new_console_events
    if new_console_events != console_events
      @rpc.call(new_console_events ? 'Console.enable' : 'Console.disable')
      @console_events = new_console_events
    end
    new_console_events
  end

  # Removes all the messages in the console.
  #
  # @return [WebkitRemote::Client] self
  def clear_console
    @rpc.call 'Console.clearMessages'
    self
  end

  # @return [Boolean] true if the debugger generates Console.* events
  attr_reader :console_events

  # @private Called by the Client constructor to set up Console data.
  def initialize_console
    @console_events = false
  end
end  # module WebkitRemote::Client::Console

initializer :initialize_console
clearer :clear_console
include WebkitRemote::Client::Console

end  # namespace WebkitRemote::Client

end  # namespace WebkitRemote