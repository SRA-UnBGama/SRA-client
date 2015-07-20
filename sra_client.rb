# file client_teste.rb
require 'socket'

IP = "localhost"
PORT = 3001
WITHOUT_PLACE = "none"


loop {

  server = TCPSocket.open( IP, PORT ) # Connect to the server

	# Receive the messenger of the server.
  msg_server = server.recvfrom( 10000 )

  place = msg_server.first.chomp

  if place != WITHOUT_PLACE
    File.open('.place_name', 'w') do |file|
      file.puts place
    end

    server.puts ''
  else

    if File.exist?('.place_name')
      place_name = File.open( '.place_name', 'r' )

      place_name.each_line do |line|
        server.puts line.chomp
      end
    else
      File.new(".place_name", "w")
      server.puts ''
    end

  end

  sleep(0.1)

  server.close
}
