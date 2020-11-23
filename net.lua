local net = {}

-- net.open_connection(
--      port: number
-- ) -> number | nil
net.open_connection = function(port)
    if (port == nil) then
        return nil
    end

    port = tonumber(port)

    if (port == nil) then
        return nil
    end

    if (port < 1 or port > 65534) then
        return nil
    end

    local modem = peripheral.find("modem")

    modem.open(port)
    return port
end

-- net.close_connection(
--      port: number
-- ) -> number | nil
net.close_connection = function(port)
    if (port == nil) then
        return nil
    end

    port = tonumber(port)

    if (port == nil) then
        return nil
    end

    if (port < 1 or port > 65534) then
        return nil
    end

    local modem = peripheral.find("modem")

    modem.close(port)
    return port
end

-- net.send_message(
--      port: number
--      destination_port: number
--      message: any
--      close_after_send: boolean
-- ) -> nil
net.send_message = function(port, destination_port, message, ...)
    local response = net.open_connection(port)
    local close_after_send = {...}

    if (response == nil) then
        print("Couldn't send message")
        return
    end

    local modem = peripheral.find("modem")

    modem.transmit(port, destination_port, message)

    if close_after_send then
        net.close_connection(port)
    end
end

return net
