local recent = {}

RegisterNetEvent("byebye", function()
    local offender = source

    if not recent[offender] then
        recent[offender] = os.time()
    else
        local timeSinceLastAttempt = os.time() - recent[offender]

        if timeSinceLastAttempt < 10 then
            return
        end

        recent[offender] = os.time()
    end

    local bye = "Blocked by: RLAC (Anti-StateBag)"
    DropPlayer(offender, bye)
end)
