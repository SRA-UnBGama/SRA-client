# file client_teste.rb
require 'socket'

loop {

  server = TCPSocket.open( 'localhost', 3001 ) # conecta ao servidor na porta 3001

  msg_server = server.recvfrom( 10000 ) # recebe a mensagem -10000 bytes - do servidor

  place = msg_server.first.chomp

  if place != "none"
    File.open('.place_name', 'w') do |p|
      p.puts place
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
