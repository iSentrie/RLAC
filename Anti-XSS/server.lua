local function isXss(str)
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

AddEventHandler('playerConnecting', function(playerName, kickReason, deferrals)
    local XSS = isXss(playerName)
    deferrals.defer()
    Wait(200)
    deferrals.defer("Authenticating Acocunt")
    Wait(500)
    if XSS then
        deferrals.done("You Are Using XSS Retard")
    else
        deferrals.done()
    end
end)