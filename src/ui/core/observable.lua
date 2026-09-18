local Observable = {}
Observable.__index = Observable

function Observable.new(value)
	return setmetatable({ value = value, subs = {} }, Observable)
end

function Observable:subscribe(fn) table.insert(self.subs, fn) end

function Observable:set(v)
	self.value = v
	for _, fn in ipairs(self.subs) do
		fn(v)
	end
end

return Observable
