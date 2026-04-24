-- IGS Tabbar — горизонтальний зверху
local PANEL = {}
local TAB_H = 40

function PANEL:Init()
	self.activity = uigs.Create("igs_multipanel", self)
	self.tabBar   = uigs.Create("Panel", self)
	self.tabBar:SetTall(TAB_H)
	self.tabBar.Paint = function(_, w, h)
		draw.RoundedBox(0, 0, 0, w, h, IGS.col.TAB_BAR)
		surface.SetDrawColor(IGS.col.HARD_LINE)
		surface.DrawLine(0, h - 1, w, h - 1)
	end
	self.Buttons = {}
end

function PANEL:SetActiveTab(num)
	for i, btn in ipairs(self.Buttons) do
		btn.Active = (num == i)
	end
	self.activity:SetActivePanel(num)
end

function PANEL:GetActiveTab()
	return self.activity:GetActivePanel()
end

function PANEL:AddTab(sTitle, panel, sIcon, bActive)
	local ID = self.activity:AddPanel(panel, bActive)

	local btn = uigs.Create("DButton", function(s)
		s:SetSize(80, TAB_H)
		s:SetText("")
		s.DoClick = function(ss)
			self:SetActiveTab(ss.ID)
		end
		s.Paint = function(ss, w, h)
			if ss.Active then
				surface.SetDrawColor(IGS.col.HIGHLIGHTING)
				surface.DrawRect(0, h - 2, w, 2)
				surface.SetTextColor(IGS.col.HIGHLIGHTING)
			elseif ss.Hovered then
				surface.SetTextColor(IGS.col.TEXT_HARD)
			else
				surface.SetTextColor(IGS.col.HIGHLIGHT_INACTIVE)
			end
			surface.SetFont("igs.18")
			local tw = surface.GetTextSize(sTitle)
			if tw + 32 ~= w then s:SetWide(tw + 32) end
			surface.SetTextPos(w / 2 - tw / 2, h / 2 - 8)
			surface.DrawText(sTitle)
		end
		s.ID     = ID
		s.Active = bActive
	end)

	function btn:Name() return sTitle end

	-- Додаємо кнопку в таббар
	btn:SetParent(self.tabBar)
	table.insert(self.Buttons, btn)

	-- Перераховуємо позиції
	local x = 16
	for _, b in ipairs(self.Buttons) do
		b:SetPos(x, 0)
		x = x + b:GetWide()
	end

	return btn
end

function PANEL:PerformLayout(w, h)
	-- Таббар зверху
	self.tabBar:SetSize(w, TAB_H)
	self.tabBar:SetPos(0, 0)
	-- Activity під таббаром
	self.activity:SetPos(0, TAB_H)
	self.activity:SetSize(w, h - TAB_H)
end

function PANEL:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, IGS.col.ACTIVITY_BG)
end

vgui.Register("igs_tabbar", PANEL, "Panel")
