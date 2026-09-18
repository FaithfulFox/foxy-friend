local Widget = {}
Widget.__index = Widget

function Widget.new()
	return setmetatable({
		x = 0,
		y = 0,
		w = 100,
		h = 20,
		visible = true,
		children = {},
	}, Widget)
end

function Widget:add(child) table.insert(self.children, child) end

function Widget:update(dt)
	for _, c in ipairs(self.children) do
		if c.update then c:update(dt) end
	end
end

function Widget:render()
	if not self.visible then return end
	for _, c in ipairs(self.children) do
		if c.render then c:render() end
	end
end

return Widget
