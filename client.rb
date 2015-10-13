#!/usr/bin/env ruby -w
require "socket"
quiting = false
class Client
  def initialize( server )
    @server = server
    @request = nil
    @response = nil
    listen
    send
    @request.join
    @response.join
  end
 
  def listen
    @response = Thread.new do
      loop {
        msg = @server.gets.chomp
	puts "#{msg}"
      }
    end
  end
 
  def send
    puts "Enter the username:"
    @request = Thread.new do
      loop {
        msg = $stdin.gets.chomp
        
	if msg == "quit"
		abort("Aborting Chat Session")
	end
	@server.puts( msg )
      }
    end
  end
end
if quiting == true
	abort("Aborting Chat Session")
end
server = TCPSocket.open( "localhost", 3000 )
Client.new( server )
