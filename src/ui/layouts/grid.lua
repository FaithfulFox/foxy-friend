local Layout = require("src.ui.core.layout")

---@class Grid: Layout
---@field cols integer
local Grid = setmetatable({}, Layout)
Grid.__index = Grid

---@class ChildSpec.gridOpts
---@field span integer max columns child should span

---@param cols integer
---@param children? ChildSpec[]
---@return Grid
function Grid.new(cols, children)
   ---@class Layout
   local self = Layout.new()
   self.cols = cols
   if children then self.children = children end

   return setmetatable(self, Grid)
end

local update_layout = function(self)
   if #self.children == 0 then return end
   local divx = self.w / self.cols
   local rows = (#self.children % self.cols) > 0
         and (#self.children / self.cols) + 1
      or (#self.children / self.cols)
   local divy = self.h / rows

   local child = 1

   for i = 1, rows, 1 do
      for j = 1, self.cols, 1 do
         if child > #self.children then break end
         local c = self.children[child]
         local copts = c.opts or {}
         local span = copts.span or 1

         c.child.x = self.x + (divx * (j - 1))
         c.child.y = self.y + (divy * (i - 1))
         c.child.w = divx * span
         c.child.h = divy

         child = child + 1
      end
   end
end

function Grid:update(dt)
   update_layout(self)
   for _, c in ipairs(self.children) do
      if c.child.update then c.child:update(dt) end
   end
end

return Grid
