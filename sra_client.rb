# file client_teste.rb
require 'socket'

IP_LOCAL = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
IP = "localhost"
PORT = 3001
WITHOUT_PLACE = "none"



loop {

  begin
    server = TCPSocket.open( IP, PORT ) # Connect to the server

    # Receive the messenger of the server.

    server.puts IP_LOCAL
    
    msg_server = server.recvfrom( 10000 )
  rescue Errno::ECONNREFUSED
    retry
   rescue Errno::ECONNRESET
    retry
  end

  place = msg_server.first.chomp

  if place != WITHOUT_PLACE
    File.open('.place_name.txt', 'w') do |file|
      file.puts place
    end

    server.puts ''
  else

    if File.exist?('.place_name.txt')
      place_name = File.open( '.place_name.txt', 'r' )

      place_name.each_line do |line|
        server.puts line.chomp
      end
    else
      File.new(".place_name.txt", "w")
      server.puts ''
    end

  end

  sleep(0.01)

  server.close
}
