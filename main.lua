function love.load() love.window.setMode(650, 650) end

function love.update(dt) end

local Component = {}
local mt = {}

function mt.__call(self, ob) return self:new(ob) end

---comment
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

function Component.new(o)
	local defaults = {
		parent = nil,
		children = nil,
		style = {
			width = nil,
			height = nil,
			padding = { top = 10, right = 10, bottom = 10, left = 10 },
			margin = { top = 10, right = 10, bottom = 10, left = 10 },
		},
	}
	if o then
		o = deep_merge(defaults, o)
	else
		o = defaults
	end

	setmetatable(o, mt)

	return o
end

function Component:draw()
	local x, y = self:resolved_position()
	love.graphics.rectangle("fill", x, y, width, height, rx, ry?, segments?)
end

function Component:resolved_position()
	local px, py = self.parent:resolved_position()
	local parent_padding = self.parent.style.padding
	local x = px + parent_padding.left + self.style.margin.left
	local y = py + parent_padding.top + self.style.margin.top

	return x, y
end

function Component:resolved_dimensions()
	local width, height = 0, 0
	local cwm, chm = 0, 0

	for i, component in ipairs(self.children) do
		local cstyle = component.style
		local cw, ch = component:resolved_dimensions()
		if ((cstyle.margin.left + cstyle.margin.right) > cwm) then
			cwm = cstyle.margin.left
		end
	
	end
end

function Component:add(component)
	component.parent = self
	table.insert(self.children, component)
end

function love.draw()
	love.graphics.setBackgroundColor(0.8, 0.25, 0.05, 1.0)

	local win_width = love.graphics.getWidth()

	local pet_padding = 25

	local UI = {
		root = Component.new({
			style = {
				padding = {
					left = 69,
				},
			},
			children = {
				Component.new(),
			},
		}),
	}

	love.graphics.print(UI.root.style.padding.left)

	love.graphics.setColor({ 0.0, 0.0, 0.0, 0.5 })
	love.graphics.rectangle(
		"fill",
		pet_padding,
		pet_padding,
		win_width - (pet_padding * 2),
		win_width - (pet_padding * 2) + (win_width * 0.5)
	)
end
