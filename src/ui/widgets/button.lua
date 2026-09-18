local Widget = require("src.ui.core.widget")

local Button = setmetatable({}, Widget)
Button.__index = Button

function Button.new(text, action)
	local self = Widget.new()
	self.text = text
	self.action = action
	return setmetatable(self, Button)
end
local function mouse_in_rect(x, y, w, h)
	local mouse_x, mouse_y = love.mouse.getPosition()
	if
		(mouse_x > x and mouse_y > y)
		and ((mouse_x < (x + w)) and (mouse_y < (y + h)))
	then
		return true
	end
	return false
end

function Button:update(dt)
	if
		love.mouse.isDown(1) and mouse_in_rect(self.x, self.y, self.w, self.h)
	then
		if self.action then self.action() end
	end
end

function Button:render()
	local text_width = love.graphics.getFont():getWidth(self.text)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.printf(
		{ { 0.0, 0.0, 0.0, 1.0 }, self.text },
		self.x + 8,
		self.y + 4,
		self.w - 4
	)
end

return Button
