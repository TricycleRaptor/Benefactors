local WorkShopDls = {}

local WorkshopMaps = {
	["2292681414"] = "ares_atrium"
}

if SERVER then
	for k, _ in pairs(WorkShopDls) do
		resource.AddWorkshop(k)
	end

	for k, v in pairs(WorkshopMaps) do
		if string.find(game.GetMap(), v) then
			resource.AddWorkshop(k)
		end
	end
end