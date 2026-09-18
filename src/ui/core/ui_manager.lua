local UIManager = {}
UIManager.__index = UIManager

function UIManager.new()
	return setmetatable({
		stack = {}, -- screen stack
		widgets = {}, -- global widgets (HUD etc.)
	}, UIManager)
end

function UIManager:push(screen)
	table.insert(self.stack, screen)
	if screen.enter then screen:enter() end
end

function UIManager:pop()
	local s = table.remove(self.stack)
	if s and s.exit then s:exit() end
end

function UIManager:update(dt)
	for _, w in ipairs(self.widgets) do
		if w.update then w:update(dt) end
	end

	local top = self.stack[#self.stack]
	if top and top.update then top:update(dt) end
end

function UIManager:render()
	local top = self.stack[#self.stack]
	if top and top.render then top:render() end

	for _, w in ipairs(self.widgets) do
		if w.render then w:render() end
	end
end

return UIManager
