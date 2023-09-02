local webhookUrl = Config.webhookUrl

AddEventHandler('playerConnecting', function(playerName, setkick, deferrals)   
    local playerIP = GetPlayerEndpoint(source)
    PerformHttpRequest(("https://proxycheck.io/v2/%s?vpn=1&asn=1"):format(playerIP), function(response)
        local dat = json.encode(response)
        if response and dat[playerIP] and dat[playerIP].proxy == "yes" then
            setkick("We Have Detected a VPN")
            PerformHttpRequest(webhookUrl, function() end, 'POST', json.encode({content = ("Detected a VPN under the IP: %s"):format(playerIP)}), { ['Content-Type'] = 'application/json' })
            CancelEvent()
        end
    end)
end)
