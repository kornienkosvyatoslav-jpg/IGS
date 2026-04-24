-- IGS Item — великі темні карточки 160x210 (макет)
local PANEL = {}

function PANEL:Init()
	self:SetSize(160, 210)
	self.item   = nil
	self.icobg  = nil
	self.icon   = nil
	self.name   = nil
	self.sign   = nil
	self.bottom = nil
end

function PANEL:SetItem(STORE_ITEM)
	self.item = STORE_ITEM

	if not IsValid(self.icobg) then
		self.icobg = vgui.Create("Panel", self)
		self.icobg.Paint = function(s, w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(23, 29, 47, 255))
		end
	end

	if not IsValid(self.icon) then
		self.icon = vgui.Create("igs_wmat", self.icobg)
		self.icon:Dock(FILL)
		self.icon:DockMargin(4, 4, 4, 4)
	end

	local ico = STORE_ITEM:ICON()
	if ico then self.icon:SetURL(ico) end

	if not IsValid(self.name) then
		self.name = vgui.Create("DLabel", self)
		self.name:SetFont("igs.18")
		self.name:SetContentAlignment(5)
	end
	self.name:SetText(STORE_ITEM:Name())
	self.name:SetTextColor(STORE_ITEM:GetHighlightColor() or Color(244, 247, 252, 255))
	self:SetTooltip(STORE_ITEM:Name())

	if not IsValid(self.sign) then
		self.sign = vgui.Create("DLabel", self)
		self.sign:SetFont("igs.15")
		self.sign:SetContentAlignment(5)
		self.sign:SetTextColor(Color(168, 177, 196, 255))
	end
	self.sign:SetText("Действ. " .. IGS.TermToStr(STORE_ITEM:Term()))

	if not IsValid(self.bottom) then
		self.bottom = vgui.Create("DLabel", self)
		self.bottom:SetFont("igs.17")
		self.bottom:SetContentAlignment(5)
		self.bottom:SetTextColor(Color(75, 181, 118, 255))
	end

	local priceStr
	if IGS.SignPrice then
		priceStr = IGS.SignPrice(STORE_ITEM:GetPrice(LocalPlayer()))
	else
		priceStr = tostring(STORE_ITEM:GetPrice(LocalPlayer())) .. " " .. (IGS.C.CURRENCY_SIGN or "грн")
	end
	self.bottom:SetText(priceStr)

	return self
end

-- Заглушки для сумісності з іншими частинами IGS
function PANEL:SetName(s)       end
function PANEL:SetSign(s)       end
function PANEL:SetBottomText(s) end
function PANEL:SetIcon(s, m)    end
function PANEL:SetTitleColor(c) end

function PANEL:PerformLayout(w, h)
	local icoH = math.floor(h * 0.54)

	if IsValid(self.icobg) then
		self.icobg:SetPos(6, 6)
		self.icobg:SetSize(w - 12, icoH)
	end

	local y = 6 + icoH + 4

	if IsValid(self.name) then
		self.name:SetPos(4, y)
		self.name:SetSize(w - 8, 22)
		y = y + 24
	end

	if IsValid(self.sign) then
		self.sign:SetPos(4, y)
		self.sign:SetSize(w - 8, 16)
	end

	if IsValid(self.bottom) then
		self.bottom:SetPos(4, h - 26)
		self.bottom:SetSize(w - 8, 22)
	end
end

function PANEL:DoClick()
	if self.item then IGS.WIN.Item(self.item:UID()) end
end

function PANEL:Paint(w, h)
	draw.RoundedBox(8, 0, 0, w, h, Color(15, 20, 31, 255))
	local col = self.Hovered
		and Color(77, 163, 255, 150)
		or  Color(255, 255, 255, 18)
	surface.SetDrawColor(col)
	surface.DrawOutlinedRect(0, 0, w, h, 1)
	surface.SetDrawColor(Color(255, 255, 255, 20))
	surface.DrawLine(6, h - 30, w - 6, h - 30)
	return true
end

function PANEL:PaintOver(w, h)
	if self.item and self.item.discounted_from then
		local orig = tostring(self.item.discounted_from) .. " " .. (IGS.C.CURRENCY_SIGN or "грн")
		surface.SetFont("igs.15")
		local tw = surface.GetTextSize(orig)
		local bx = w / 2 - tw / 2
		local by = h - 44
		surface.SetTextColor(Color(168, 177, 196, 130))
		surface.SetTextPos(bx, by)
		surface.DrawText(orig)
		surface.SetDrawColor(Color(168, 177, 196, 100))
		surface.DrawLine(bx, by + 7, bx + tw, by + 7)
	end
end

vgui.Register("igs_item", PANEL, "DButton")
