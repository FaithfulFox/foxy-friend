function love.load()
	love.window.setMode(650, 650)
	UI = require("src.ui.core.ui_manager").new()
	local menu = require("src.ui.screens.menu")
	UI:push(menu)
end

function love.update(dt) UI:update(dt) end

---@param destination any[]
---@param source any[]
local function deep_merge(destination, source)
	for key, value in pairs(source) do
		if
			type(value) == "table"
			and type(destination[key]) == "table"
			and not (value[1] or destination[key][1])
		then
			-- Recursively merge nested maps
			deep_merge(destination[key], value)
		else
			-- Replace scalars, arrays, or mismatched types
			destination[key] = value
		end
	end

	return destination
end

function love.draw()
	love.graphics.setBackgroundColor(0.8, 0.25, 0.05, 1.0)

	UI:render()
end
