local webhookUrl = Config.webhookUrl
local playerIP = GetPlayerEndpoint(source)
local api = string.format("https://proxycheck.io/v2/%s?vpn=1&asn=1", playerIP)
local api2 = json.decode(response or "")
local message = string.format("RLAC: Detected VPN, ip:", playerIP) 

AddEventHandler('playerConnecting', function(playerName, kick, deferrals)   
    PerformHttpRequest(api, function(response)
        if api2 and api2[playerIP] and api2[playerIP].proxy == "yes" then
            kick("No VPNs allowed on this server.")
            PerformHttpRequest(webhookURL, function() end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
            CancelEvent()
        end
    end)
 end)