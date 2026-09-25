local Widget = require("src.ui.core.widget")

local Button = setmetatable({}, Widget)
Button.__index = Button

---@param text string
---@param action function
---@return Widget
function Button.new(text, action)
   ---@class Widget
   local self = Widget.new()
   self.text = text
   self.action = action
   self.active = false
   self.hover = false
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
   if mouse_in_rect(self.x, self.y, self.w, self.h) then
      self.hover = true
      if love.mouse.isDown(1) then
         if self.action then self.action() end
         self.active = true
      else
         self.active = false
      end
   else
      self.hover = false
   end
end

function Button:render()
   local r, g, b, a = love.graphics.getColor()
   if self.hover then love.graphics.setColor(1.0, 0.0, 0.0, 1.0) end
   love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

   local text_width = love.graphics.getFont():getWidth(self.text)
   local text_height = love.graphics.getFont():getHeight(self.text)
   love.graphics.printf(
      { { 0.0, 0.0, 0.0, 1.0 }, self.text },
      (self.x + (self.w / 2)) - (text_width / 2),
      (self.y + (self.h / 2)) - (text_height / 2),
      self.w - 4
   )

   love.graphics.setColor(r, g, b, a)
end

return Button
