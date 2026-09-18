local Widget = require("src.ui.core.widget")

local Canvas = setmetatable({}, Widget)
Canvas.__index = Canvas

function Canvas.new(background)
	local self = Widget.new()
	self.background = background
	return setmetatable(self, Canvas)
end

function Canvas:render()
	if not self.visible then return end

	local win_width = love.graphics.getWidth()
	local padding = 25

	local pr, pg, pb, pa = love.graphics.getColor()
	love.graphics.setColor(self.background)
	love.graphics.rectangle(
		"fill",
		padding,
		padding,
		win_width - (padding * 2),
		win_width - (padding * 2) + (win_width * 0.5)
	)
	Widget.render(self)
	love.graphics.setColor({ pr, pg, pb, pa })
end

return Canvas
