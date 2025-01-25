local barLength = 12
local full = "█"
local empty = " "


local function execCommand(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end
local function round(num)
    return math.floor(num + 0.5)
end

local currentTrackPosition = tonumber(execCommand("playerctl metadata --format \" {{ position }}\""))
local trackLength = tonumber(execCommand("playerctl metadata --format \" {{ mpris:length }}\""))

if not currentTrackPosition then
	print("{\"text\":\"nothing playing\"}")
	return
end

local needToFill
if trackLength ~= 0 then
	needToFill = round((currentTrackPosition / trackLength) * barLength)
else
	needToFill = 0
end

local filledPart = string.rep(full, needToFill)
local emptyPart = string.rep(empty, barLength - needToFill)

print(string.format("{\"text\":\"%s\"}", filledPart .. emptyPart))
