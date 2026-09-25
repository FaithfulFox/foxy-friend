local Widget = require("src.ui.core.widget")

---@class Label
---@field text string
---@field align string
local Label = setmetatable({}, Widget)
Label.__index = Label

---@param text string
---@param align? "left"|"center"|"right"
---@return Label
---@overload fun(text: string): Label
---@overload fun(text: string, align: "left"|"center"|"right"): Label
function Label.new(text, align)
   ---@class Widget
   local self = Widget.new()
   self.text = text
   self.align = align or "left"
   return setmetatable(self, Label)
end

function Label:render()
   if not self.visible then return end
   love.graphics.printf(self.text, self.x, self.y, self.w, self.align)
   Widget.render(self)
end

return Label
