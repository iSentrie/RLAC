local webhookURL = '' -- Discord webhook URL
local kickMsg = 'Nice Try.'

local function gayXSS(str)
    local patterns = {
        "<%w", "</%w", "<style>.*</style>", "<script>.*</script>", "&%w+;", "javascript:", "window%.", 
        "document%.", "alert%(", "function%(", "console%.log%(", "var% ", "let% ", "const% ", "%(", "%)", "{", "}", 
        "%[", "%]", '""', '"', "'", "`", "=", "+", "-", "*", "/", ":", ";", "%.", "!", "@", "#", "|", "&"
    }

    for _, pattern in ipairs(patterns) do
        if string.match(str, pattern) then
            return true
        end
    end
    return false
end

AddEventHandler('playerConnecting', function(playerName, kick, deferrals)
    if gayXSS(playerName) then
        local identifiers = GetPlayerIdentifiers(source)
        local steamID, discordID = nil, nil
        
        for _, id in ipairs(identifiers) do
            if string.sub(id, 1, 6) == "steam:" then
                steamID = id
            elseif string.sub(id, 1, 9) == "discord:" then
                discordID = id
            end
        end
        
        deferrals.done(kickMsg)
        sendToDiscord(playerName, steamID, discordID)
    end
end)

function sendToDiscord(name, steam, discord)
    local message = string.format("RLAC: %s\nSteam ID: %s\nDiscord ID: %s", name, steam or "N/A", discord or "N/A")
    PerformHttpRequest(webhookURL, function() end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end
