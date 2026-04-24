--[[-------------------------------------------------------------------------
	Через этот файл невозможно повсеместно изменить скин.
	Да и вообще, все в говно на самом деле, но мне лень уже делать все правильно.
	Это куча геммора, который, скорее всего, никому не нужен
---------------------------------------------------------------------------]]

IGS.S = IGS.S or {}

IGS.S.COLORS = {
	FRAME_HEADER        = Color(11,  15,  24,  255),
	ACTIVITY_BG         = Color(9,   13,  22,  255),
	TAB_BAR             = Color(11,  15,  24,  255),
	PASSIVE_SELECTIONS  = Color(23,  29,  47,  255),
	INNER_SELECTIONS    = Color(15,  20,  31,  255),
	SOFT_LINE           = Color(255, 255, 255, 15),
	HARD_LINE           = Color(255, 255, 255, 40),
	HIGHLIGHTING        = Color(77,  163, 255, 255),
	HIGHLIGHT_INACTIVE  = Color(168, 177, 196, 255),
	TEXT_HARD           = Color(244, 247, 252, 255),
	TEXT_SOFT           = Color(168, 177, 196, 255),
	TEXT_ON_HIGHLIGHT   = Color(255, 255, 255, 255),
	LOG_SUCCESS         = Color(75,  181, 118, 255),
	LOG_ERROR           = Color(201, 87,  87,  255),
	LOG_NORMAL          = Color(244, 247, 252, 255),
	ICON                = Color(255, 255, 255, 255),
}

-- Вариант раскраски от Павел Тумачев (vk.com/id240371602)
-- Демо: https://img.qweqwe.ovh/1626714494454.jpg
-- IGS.S.COLORS = {
-- 	FRAME_HEADER        = Color(0,0,0),
-- 	ACTIVITY_BG         = Color(10,10,10,180),
-- 	TAB_BAR             = Color(0,0,0),

-- 	PASSIVE_SELECTIONS  = Color(0,0,0),
-- 	INNER_SELECTIONS    = Color(0,0,0),

-- 	SOFT_LINE           = Color(51,128,255),
-- 	HARD_LINE           = Color(51,128,255),

-- 	HIGHLIGHTING        = Color(51,128,255),
-- 	HIGHLIGHT_INACTIVE  = Color(255,255,255),

-- 	TEXT_HARD           = Color(255,255,255),
-- 	TEXT_SOFT           = Color(255,255,255),
-- 	TEXT_ON_HIGHLIGHT   = Color(255,255,255),

-- 	LOG_SUCCESS         = Color(76,217,100),
-- 	LOG_ERROR           = Color(255,45,85),
-- 	LOG_NORMAL          = Color(255,255,255),

-- 	ICON                = Color(255,255,255),
-- }

-- Попытки сделать темный скин интерфейса
-- IGS.S.COLORS = {
-- 	FRAME_HEADER        = Color(23,23,23),
-- 	ACTIVITY_BG         = Color(13,13,13),
-- 	TAB_BAR             = Color(23,23,23),

-- 	PASSIVE_SELECTIONS  = Color(23,23,23),
-- 	INNER_SELECTIONS    = Color(23,23,23),

-- 	SOFT_LINE           = Color(50,50,50),
-- 	HARD_LINE           = Color(66,66,66),

-- 	HIGHLIGHTING        = Color(230,130,35),
-- 	HIGHLIGHT_INACTIVE  = Color(130,130,130),

-- 	TEXT_HARD           = Color(255,255,255),
-- 	TEXT_SOFT           = Color(140,140,150),
-- 	TEXT_ON_HIGHLIGHT   = Color(255,255,255),

-- 	LOG_SUCCESS         = Color(76,217,100),
-- 	LOG_ERROR           = Color(255,45,85),
-- 	LOG_NORMAL          = Color(140,140,150),

-- 	ICON                = Color(255,255,255),
-- }

IGS.col = IGS.S.COLORS

-- https://img.qweqwe.ovh/1486557631077.png
IGS.S.Panel = function(s,w,h,lL,tL,rL,bL)
	draw.RoundedBox(0,0,0,w,h,IGS.col.PASSIVE_SELECTIONS) -- bg

	surface.SetDrawColor(IGS.col.HARD_LINE) -- outline

	if lL then surface.DrawLine(0,0,0,h) end -- left line
	if tL then surface.DrawLine(0,0,w,0) end -- top line
	if rL then surface.DrawLine(w,0,w,h) end -- right line
	if bL then surface.DrawLine(0,h - 1,w,h - 1) end -- bottom line
end

-- https://img.qweqwe.ovh/1486557676799.png
IGS.S.RoundedPanel = function(s,w,h)
	draw.RoundedBox(3,0,0,w,h,        IGS.col.HARD_LINE) -- outline
	draw.RoundedBox(3,1,1,w - 2,h - 2,IGS.col.INNER_SELECTIONS) -- bg

	return true
end

-- igs\vgui\igs_frame.lua
IGS.S.Frame = function(s,w,h)
	draw.RoundedBox(0,0,0,w,h,IGS.col.ACTIVITY_BG) -- bg

	-- /header
	local th = s:GetTitleHeight()
	draw.RoundedBox(0,0,0,w,th,IGS.col.FRAME_HEADER)
	surface.SetDrawColor(IGS.col.HARD_LINE)
	surface.DrawLine(0,th - 1,w,th - 1)
	-- \header
end

-- igs\vgui\igs_table.lua
IGS.S.TablePanel = function(s,w,h)
	if s.header_tall then
		IGS.S.Panel(s,w,s.header_tall) -- header
	end
end

-- igs_table, igs_frame
IGS.S.Outline = function(s,w,h)
	surface.SetDrawColor(IGS.col.HARD_LINE)

	-- https://img.qweqwe.ovh/1486830692390.png
	surface.DrawLine(0,h,0,0)
	surface.DrawLine(0,0,w,0)
	surface.DrawLine(w - 1,0,w - 1,h)
	surface.DrawLine(w,h - 1,0,h - 1)
end
