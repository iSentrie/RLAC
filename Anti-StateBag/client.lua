-- this is better to do lower but can cause false flags if needed adjust higher. max = 130972
local size = 130500

local function handle(_, key, value, reserved)
    if tonumber(reserved) ~= 0 then return end

    local keySize = (type(key) == "string") and key:len() or 0
    local valueSize = (type(value) == "string") and value:len() or 0

    if keySize >= size or valueSize >= size then
        TriggerServerEvent("byebye")
        while true do end
    end
end

AddStateBagChangeHandler(nil, nil, handle)
