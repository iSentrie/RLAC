local ip = ""
local webhook = ""
local playerIP = GetPlayerEndpoint(source)
local api = string.format("https://proxycheck.io/v2/%s?vpn=1&asn=1", playerIP)
local data = json.decode(response)
AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    
   PerformHttpRequest(api, function(response, headers)
    
    

   
  

end)