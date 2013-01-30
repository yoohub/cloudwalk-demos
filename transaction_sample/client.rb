require 'socket'
require 'string2hex'

#server = TCPSocket.open('ec2-23-23-49-158.compute-1.amazonaws.com',2000)
#server = TCPSocket.open('localhost',2000)
server = TCPSocket.open('demo.cloudwalk.io',2000)

a = "2"
b = "109900"
c = "1234123412341234"
d = "1234"

server.puts a+"#"+b+"#"+c+"#"+d
#puts a+"#"+b+"#"+c+"#"+d
#server.puts " "

line = server.recv(1024)
hexa = line.split('#')
param1 = hexa[0]
param2 = hexa[1]
param3 = hexa[2]

puts "Param1: #{param1}"
puts "Param2: #{param2}"
puts "Param3: #{param3}"

server.close