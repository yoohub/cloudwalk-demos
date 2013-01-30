require 'socket'
require 'string2hex'
require './definitions_file'

#file_log = File.new("/var/log/auth_log.txt","w")
#file_log.close

server = TCPServer.new 15555
count = 1
d = Definitions.new

#d.save_log("#{Process.pid}")

loop do
  client = server.accept
  #d.save_log("Client Connected")
  puts "Client Connected"
  line = client.recv(1024)
  puts line
	hexa = line.split('#')
  param3 = count.to_s
  count += 1

  if hexa[0] != 0 && hexa[1] != 0 && hexa [2] != 0
    if hexa[1].to_i < 10000 #Aproved Credit till 100,00
      if hexa[2].to_i == 1234123412341234 #If card number is correct
        if hexa[0].to_i == 1 #If is credit
          #Aproved transaction
          param1 = "ACCEPT"
          param2 = "OK"
          #d.show_incoming_message(hexa,line)
          #d.save_log("CREDIT - ACCEPT Value: #{hexa[1]}")
        else #If its debit
          puts hexa[3]
          if hexa[3].to_i == 1234
            #password ok, aproved
            param1 = "ACCEPT"
            param2 = "OK"
            #d.show_incoming_message(hexa,line)
            #d.save_log("DEBIT - ACCEPT Value: #{hexa[1]}")
          else
            #wrong password
            param1 = "REFUSED"
            param2 = "WRONG_PASSWORD"
            #d.show_incoming_message(hexa,line)
            #d.save_log("DEBIT - REFUSED WRONG_PASSWORD")
          end
        end
      else
        #Card or account invalid
        param1 = "REFUSED"
        param2 = "WRONG_CARD/ACCOUNT"
        #d.show_incoming_message(hexa,line)
        #d.save_log("DEBIT - REFUSED WRONG_CARD/ACCOUNT")
      end
    else
      #INSUFFICIENT_FOUNDS
      param1 = "REFUSED"
      param2 = "INSUFFICIENT_FOUNDS"
      #d.show_incoming_message(hexa,line)
      #d.save_log("DEBIT - REFUSED INSUFFICIENT_FOUNDS")
    end
    client.puts param1+"#"+param2+"#"+param3
    puts " "
    #d.save_log("CLOSED CONNECTION")
    client.close
  end
end