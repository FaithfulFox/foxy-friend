---@class Layout
---@field x integer
---@field y integer
---@field w integer
---@field h integer
---@field visible boolean
---@field children ChildSpec[]
local Layout = {}
Layout.__index = Layout

---@class ChildSpec
---@field child Widget|Layout
---@field opts table

function Layout.new()
   return setmetatable({
      x = 0,
      y = 0,
      w = 100,
      h = 20,
      visible = true,
      children = {},
   }, Layout)
end

function Layout:add(child)
   table.insert(self.children, child)
end

function Layout:update(dt)
   for _, c in ipairs(self.children) do
      if c.child.update then c.child:update(dt) end
   end
end

function Layout:render()
   if not self.visible then return end
   for _, c in ipairs(self.children) do
      if c.child.render then c.child:render() end
   end
end

return Layout
