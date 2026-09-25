local Canvas = require("src.ui.widgets.canvas")
local Grid = require("src.ui.layouts.grid")
local Button = require("src.ui.widgets.button")

local Game = {}

function Game:enter()
   self.pet_window = Canvas.new({ 0.7, 0.2, 0.03, 1.0 })

   self.controls = Grid.new(2)
   self.controls.w = 400
   self.controls.h = 300
   self.controls.x = (love.graphics.getWidth() / 2) - (self.controls.w / 2)
   self.controls.y = 20
   self.controls:add({ child = Button.new("Feed", function() end) })
   self.controls:add({ child = Button.new("Play", function() end) })
   self.controls:add({ child = Button.new("Sleep", function() end) })
   self.controls:add({ child = Button.new("Clean", function() end) })
   local meta_buttons = Grid.new(3)
   meta_buttons:add({
      child = Button.new("Menu", function()
         UI:pop()
      end),
      opts = { span = 3 },
   })
   self.controls:add({ child = meta_buttons, opts = { span = 2 } })
end

function Game:update(dt)
   self.pet_window:update(dt)
   self.controls:update(dt)
end

function Game:render()
   self.pet_window:render()
   self.controls:render()
end

return Game
