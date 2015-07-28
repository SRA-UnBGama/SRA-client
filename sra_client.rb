# file client_teste.rb
require 'socket'

PORT = 3001
WITHOUT_PLACE = "none"

begin
  client = TCPServer.open(PORT) # Connect to the server
rescue Errno::ECONNREFUSED
  retry
end


loop {

  server = client.accept
  
  begin
    # Receive the messenger of the server
    msg_server = server.recvfrom( 10000 )
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

  server.close
}

client.close