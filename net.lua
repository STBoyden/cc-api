local net = { max_fails = 3 }

check_port = function(port) 
    if (port == nil) then
        print("Supplied port is nil")
        return nil
    end

    port = tonumber(port)

    if (port == nil) then
        print(port.." is not a valid port")
        return nil
    end

    if (port < 1 or port > 65534) then
        print(port.." does not fall between 1 and 65535")
        return nil
    end

    return port
end

-- net.open_connection (
--      port: number
-- ) -> boolean
net.open_connection = function(port)
    local res = check_port(port)

    if (res == nil) then
        return false
    end

    local modem = peripheral.find("modem")

    modem.open(port)
    return true
end

-- net.close_connection (
--      port: number
-- ) -> boolean
net.close_connection = function(port)
    local res = check_port(port)

    if (res == nil) then
        return false
    end

    local modem = peripheral.find("modem")

    modem.close(port)
    return true
end

-- net.message_send (
--      port: number
--      destination_port: number
--      message: any
--      close_after_send: boolean
-- ) -> nil
net.message_send = function(port, destination_port, message, close_after_send)
    if not (net.open_connection(port)) then
        print("("..port..") Couldn't send message")
        return nil
    end

    local modem = peripheral.find("modem")

    modem.transmit(tonumber(port), check_port(destination_port), message)

    if close_after_send == true then
        net.close_connection(port)
    end
end

-- net.message_listen (
--      port: number
-- ) -> table | nil
net.message_listen = function(port)
    if not (net.open_connection(port)) then
        print("Couldn't recieve message on port " ..port)
        return nil
    end

    local event, side, send_port, recieve_port, message, distance
        = os.pullEvent("modem_message")

    return {port=recieve_port, message=message}
end

-- net.message_listen_poll (
--      port: number
--      messages: table
-- )
net.message_listen_poll = function(port, messages) 
    local fails = 0
    repeat
        local res = net.message_listen(port)
        
        if (res == nil and fails < net.max_fails) then
            fails = fails + 1
        else
            table.insert(messages, res.message)
            print(res.message)
        end
    until fails == 3
    net.close_connection(port)
end

return net
