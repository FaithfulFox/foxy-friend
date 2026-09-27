local Canvas = require("src.ui.widgets.canvas")
local Grid = require("src.ui.layouts.grid")
local Button = require("src.ui.widgets.button")

local Game = {}

function Game:enter()
   self.game = Grid.new(1)
   self.game.x = 0
   self.game.y = 0
   self.game.w = love.graphics.getWidth()
   self.game.h = love.graphics.getHeight()

   self.pet_window = Canvas.new({ 0.7, 0.2, 0.03, 1.0 })

   self.controls = Grid.new(2)
   self.controls.padding = 10
   self.controls.w = 400
   self.controls.h = 300
   self.controls.x = (love.graphics.getWidth() / 2) - (self.controls.w / 2)
   self.controls.y = 20
   self.controls:add({ child = Button.new("Feed", function() end) })
   self.controls:add({ child = Button.new("Play", function() end) })
   self.controls:add({ child = Button.new("Sleep", function() end) })
   self.controls:add({ child = Button.new("Clean", function() end) })
   local meta_buttons = Grid.new(5)
   meta_buttons:add({
      child = Button.new("Inventory", function() end),
   })
   meta_buttons:add({
      child = Button.new("Menu", function()
         UI:pop()
      end),
      opts = { span = 2 },
   })
   meta_buttons:add({
      child = Button.new("yo mama", function() end),
   })
   self.controls:add({ child = meta_buttons, opts = { span = 2 } })

   self.game:add({ child = self.pet_window })
   self.game:add({ child = self.controls })
end

function Game:update(dt)
   self.game:update(dt)
end

function Game:render()
   self.game:render()
end

return Game
