if not game:IsLoaded() then
	game.Loaded:Wait()
end

local items = {Bloc = 1, Food = 1, Fuse = 1, Batt = 1}
local active = false
local workspace = game:GetService("Workspace")
local function user() return game:GetService("Players").LocalPlayer end
local function char() return user().Character end

if game:GetService("MarketplaceService"):GetProductInfo(7991339063).Updated ~= "2022-08-06T00:14:18.39Z" then
	user():Kick("This script is outdated with the current update.")
end

user().OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
		syn.queue_on_teleport("loadstring(game:HttpGet('https://pastebin.com/raw/G9BeM7pe'))()")
	end
end)

if game.PlaceId == 7991339063 then
	while wait(1) do
		char().HumanoidRootPart.CFrame = CFrame.new(Vector3.new(298.5892333984375, 57.64155197143555, -1032.72863769531250))
	end
elseif game.PlaceId ~= 8888615802 then
	user():Kick('This script is designed to run on "Rainbow Friends" only.')
end

local function touch(part)
    firetouchinterest(part, char().HumanoidRootPart, 1)
    wait()
    firetouchinterest(part, char().HumanoidRootPart, 0)
end

local function existsItemWorkspace()
	for _,v in pairs(workspace:GetChildren()) do
		for i,_ in pairs(items) do
		    if v.Name:sub(1,4) == i then
		        return true
		    end
		end
	end
	return false
end

local function existsItemBackpack()
	for _,v in pairs(char():GetChildren()) do
		for i,_ in pairs(items) do
		    if v.Name:sub(1,4) == i then
		        return true
		    end
		end
	end
	return false
end

local function finishLevel()
    active = true
	while wait() do
		for _,v in pairs(workspace:GetChildren()) do
			if items[v.Name:sub(1,4)] then
				touch(v.TouchTrigger)
			end
		end
		repeat
			touch(workspace.GroupBuildStructures:FindFirstChildOfClass("Model").Trigger)
			if existsItemBackpack() then char().Humanoid:UnequipTools() end
		until ((not user().Backpack:FindFirstChildWhichIsA("Tool")) and (not existsItemBackpack()))
		if not existsItemWorkspace() then active = false return end
	end
end

if existsItemWorkspace() then
    finishLevel()
end

workspace.ChildAdded:Connect(function(input)
	for i,_ in pairs(items) do
	    if input.Name:sub(1,4) == i then
	        if not active then finishLevel() end
	        return
	    end
	end
end)

spawn(function()
	local oldBalance = user().PlayerGui.PermanentGUI.Shop.Shop.coinBalance.fill.value.Text:gsub(",", "")
	while wait() do
		local newBalance = user().PlayerGui.PermanentGUI.Shop.Shop.coinBalance.fill.value.Text:gsub(",", "")
		if newBalance ~= oldBalance then
			if tonumber(newBalance) - tonumber(oldBalance) == 125 then
				wait(1)
				game:GetService("TeleportService"):Teleport(7991339063, user())
			else
				oldBalance = newBalance
			end
		end
	end
end)
