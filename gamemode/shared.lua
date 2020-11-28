GM.Name		= "Benefactors"
GM.Author	= "TricycleRaptor"
GM.Email	= "arrinbevers@yahoo.com"
GM.Website  = ""
GM.TeamBased = true
DeriveGamemode( "base" )

-- ███████╗███╗   ██╗██╗   ██╗███╗   ███╗███████╗
-- ██╔════╝████╗  ██║██║   ██║████╗ ████║██╔════╝
-- █████╗  ██╔██╗ ██║██║   ██║██╔████╔██║███████╗
-- ██╔══╝  ██║╚██╗██║██║   ██║██║╚██╔╝██║╚════██║
-- ███████╗██║ ╚████║╚██████╔╝██║ ╚═╝ ██║███████║
-- ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

REALM_SH = 0
REALM_CL = 1
REALM_SV = 2

--███████╗██╗██╗     ███████╗     █████╗ ██╗   ██╗████████╗ ██████╗ ██╗      ██████╗  █████╗ ██████╗
--██╔════╝██║██║     ██╔════╝    ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██║     ██╔═══██╗██╔══██╗██╔══██╗
--█████╗  ██║██║     █████╗      ███████║██║   ██║   ██║   ██║   ██║██║     ██║   ██║███████║██║  ██║
--██╔══╝  ██║██║     ██╔══╝      ██╔══██║██║   ██║   ██║   ██║   ██║██║     ██║   ██║██╔══██║██║  ██║
--██║     ██║███████╗███████╗    ██║  ██║╚██████╔╝   ██║   ╚██████╔╝███████╗╚██████╔╝██║  ██║██████╔╝
--╚═╝     ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝

local function getRealm(dir)
	local sub = string.lower(string.sub(dir, 0, 3))
	local realm = (sub == "cl_" and REALM_CL) or (sub == "sv_" and REALM_SV) or REALM_SH
	return realm
end

local dirSorter = function(a, b)
	local aRealm = getRealm(a)
	local bRealm = getRealm(b)
	if (aRealm == bRealm) then
		return a < b
	else
		return aRealm < bRealm
	end
end

local function InitFiles(dir, realm)
	realm = realm or getRealm(dir)
	local fil, fol = file.Find(dir.."/*", "LUA")
	table.sort(fil, dirSorter)

	for _, v in ipairs(fil or {}) do
		local fileRealm = realm and realm ~= REALM_SH and realm or getRealm(v)
		if fileRealm ~= REALM_SV then -- Only cl_ files will pass this check and is loaded only on the client
			AddCSLuaFile(dir.."/"..v)
			if CLIENT then
				include(dir.."/"..v)
			end
			print("Loading "..dir.."/"..v.." on the CLIENT...")
		end
		if SERVER and fileRealm ~= REALM_CL then -- Only sv_ files will pass this check and is loaded only on the server.
			include(dir.."/"..v)
			print("Loading "..dir.."/"..v.." on the server...")
		end --Everytihng else, such as sh_, will pass both checks and is shared.
	end

	for _, folder in ipairs(fol) do
		local folderRealm = getRealm(folder)
		if folder == "noload" then continue end

		print("Mounting Folder: "..dir.." on "..(SERVER and "server" or "client"))
		InitFiles(dir.."/"..folder, folderRealm)
	end

end

InitFiles(GM.Name.."/gamemode/lib") -- Load libraries first`
InitFiles(GM.Name.."/gamemode/core") -- Load the core gamemode
InitFiles(GM.Name.."/gamemode/data") -- load gamemode data - teams, items, weapons, ect. Might be better to make this seperate in the future with a schema gamemode or addon. Works for now.