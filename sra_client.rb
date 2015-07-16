# file client_teste.rb
require 'socket'

loop {
	IP = "localhost"
	PORT = 3001

  server = TCPSocket.open( IP, PORT ) # Connect to the server

	# Receive the messenger of the server.
  msg_server = server.recvfrom( 10000 )

  place = msg_server.first.chomp

	WITHOUT_PLACE = "none"

  if place != WITHOUT_PLACE
    File.open('.place_name', 'w') do |file|
      file.puts place
    end

    server.puts ''
  else
    place_name = File.open( '.place_name', 'r' )

    place_name.each_line do |line|
      server.puts line.chomp
    end
  end

  sleep(0.1)

  server.close
}
