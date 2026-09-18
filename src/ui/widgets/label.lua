local Widget = require("src.ui.core.widget")

local Label = setmetatable({}, Widget)
Label.__index = Label

function Label.new(text)
	local self = Widget.new()
	self.text = text
	return setmetatable(self, Label)
end

function Label:render()
	if not self.visible then return end
	love.graphics.printf(self.text, self.x, self.y, self.w, "center")
	Widget.render(self)
end

return Label
