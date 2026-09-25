local Tween = {}
Tween.__index = Tween

function Tween.new(obj, prop, to, duration)
   return setmetatable({
      obj = obj,
      prop = prop,
      start = obj[prop],
      target = to,
      t = 0,
      duration = duration,
   }, Tween)
end

function Tween:update(dt)
   self.t = self.t + dt
   local p = math.min(self.t / self.duration, 1)
   self.obj[self.prop] = self.start + (self.target - self.start) * p
   if self.obj.update then self.obj:update(dt) end
end

function Tween:render()
   if self.obj.render then self.obj:render() end
end

return Tween
