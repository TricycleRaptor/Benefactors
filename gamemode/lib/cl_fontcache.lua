-- CurPda.FontsMade = false

FontCache = {}

function BuildFont(id, data, forceremake)
	if not forceremake and FontCache[id] then return end
	FontCache[id] = true
	surface.CreateFont(id,data)
end

BuildFont("DebugFixed", {
	font = "Courier New",
	size = 10,
	weight = 500,
	antialias = true,
})

BuildFont("DebugFixedSmall", {
	font = "Courier New",
	size = 7,
	weight = 500,
	antialias = true,
})

BuildFont("DefaultFixedOutline", {
	font = "Lucida Console",
	size = 10,
	weight = 0,
	outline = true,
})

BuildFont("MenuItem", {
	font = "Tahoma",
	size = 12,
	weight = 500,
})

BuildFont("Default", {
	font = "Tahoma",
	size = 13,
	weight = 500,
})

BuildFont("TabLarge", {
	font = "Tahoma",
	size = 13,
	weight = 700,
	shadow = true,
})

BuildFont("DefaultBold", {
	font = "Tahoma",
	size = 13,
	weight = 1000,
})

BuildFont("DefaultUnderline", {
	font = "Tahoma",
	size = 13,
	weight = 500,
	underline = true,
})

BuildFont("DefaultSmall", {
	font = "Tahoma",
	size = 1,
	weight = 0,
})

BuildFont("DefaultSmallDropShadow", {
	font = "Tahoma",
	size = 11,
	weight = 0,
	shadow = true,
})

BuildFont("DefaultVerySmall", {
	font = "Tahoma",
	size = 10,
	weight = 0,
})

BuildFont("DefaultLarge", {
	font = "Tahoma",
	size = 16,
	weight = 0,
})

BuildFont("UiBold", {
	font = "Tahoma",
	size = 12,
	weight = 1000,
})

BuildFont("MenuLarge", {
	font = "Verdana",
	size = 15,
	weight = 600,
	antialias = true,
})

BuildFont("ConsoleText", {
	font = "Lucida Console",
	size = 10,
	weight = 500,
})

BuildFont("Marlett", {
	font = "Marlett",
	size = 13,
	weight = 0,
	symbol = true,
})

BuildFont("Trebuchet24", {
	font = "Trebuchet MS",
	size = 24,
	weight = 900,
})

BuildFont("Trebuchet22", {
	font = "Trebuchet MS",
	size = 22,
	weight = 900,
})

BuildFont("Trebuchet20", {
	font = "Trebuchet MS",
	size = 20,
	weight = 900,
})

BuildFont("Trebuchet19", {
	font = "Trebuchet MS",
	size = 19,
	weight = 900,
})

BuildFont("Trebuchet18", {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
})

BuildFont("HUDNumber", {
	font = "Trebuchet MS",
	size = 40,
	weight = 900,
})

BuildFont("HUDNumber1", {
	font = "Trebuchet MS",
	size = 41,
	weight = 900,
})

BuildFont("HUDNumber2", {
	font = "Trebuchet MS",
	size = 42,
	weight = 900,
})

BuildFont("HUDNumber3", {
	font = "Trebuchet MS",
	size = 43,
	weight = 900,
})

BuildFont("HUDNumber4", {
	font = "Trebuchet MS",
	size = 44,
	weight = 900,
})

BuildFont("HUDNumber5", {
	font = "Trebuchet MS",
	size = 45,
	weight = 900,
})

BuildFont("HudHintTextLarge", {
	font = "Verdana",
	size = 14,
	weight = 1000,
	antialias = true,
	additive = true,
})

BuildFont("HudHintTextSmall", {
	font = "Verdana",
	size = 11,
	weight = 0,
	antialias = true,
	additive = true,
})

BuildFont("CenterPrintText", {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
	antialias = true,
	additive = true,
})

BuildFont("DefaultFixed", {
	font = "Lucida Console",
	size = 10,
	weight = 0,
})

BuildFont("DefaultFixedDropShadow", {
	font = "Lucida Console",
	size = 10,
	weight = 0,
	shadow = true,
})

BuildFont("CloseCaption_Normal", {
	font = "Tahoma",
	size = 16,
	weight = 500,
})

BuildFont("CloseCaption_Italic", {
	font = "Tahoma",
	size = 16,
	weight = 500,
	italic = true,
})

BuildFont("CloseCaption_Bold", {
	font = "Tahoma",
	size = 16,
	weight = 900,
})

BuildFont("CloseCaption_BoldItalic", {
	font = "Tahoma",
	size = 16,
	weight = 900,
	italic = true,
})

BuildFont("TargetID", {
	font = "Trebuchet MS",
	size = 22,
	weight = 900,
	antialias = true,
})

BuildFont("TargetIDSmall", {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
	antialias = true,
})

BuildFont("BudgetLabel", {
	font = "Courier New",
	size = 14,
	weight = 400,
	outline = true,
})
