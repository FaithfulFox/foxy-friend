local Event = {}
Event.__index = Event

function Event.new() return setmetatable({ listeners = {} }, Event) end

function Event:on(event, fn)
	self.listeners[event] = self.listeners[event] or {}
	table.insert(self.listeners[event], fn)
end

function Event:emit(event, ...)
	for _, fn in ipairs(self.listeners[event] or {}) do
		fn(...)
	end
end

return Event
