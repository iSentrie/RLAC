AddEventHandler('playerConnecting', function(playerName, kick, deferrals)
   local playerIP = GetPlayerEndpoint(source)
   local api = string.format("https://proxycheck.io/v2/%s?vpn=1&asn=1", playerIP)
   
   PerformHttpRequest(api, function(response)
       local api2 = json.decode(response or "")

       if api2 and api2[playerIP] and api2[playerIP].proxy == "yes" then
           kick("No VPNs allowed on this server.")
           CancelEvent()
       end
   end)
end)