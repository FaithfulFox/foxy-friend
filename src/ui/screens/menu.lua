local Label = require("src.ui.widgets.label")
local Button = require("src.ui.widgets.button")
local Tween = require("src.ui.animations.tween")

local Menu = {}

function Menu:enter()
   local font = love.graphics.newFont(30)
   love.graphics.setFont(font)

   local button_height = 60

   self.title = Label.new("Foxy Friends", "center")
   self.title.w = (love.graphics.getWidth() / 3) * 2
   self.title.x = (love.graphics.getWidth() / 2) - (self.title.w / 2)
   self.title.y = -40
   self.title_animation = Tween.new(self.title, "y", 80, 0.4)

   self.play = Button.new("Play", function()
      UI:push(require("src.ui.screens.game"))
   end)

   self.play.w = love.graphics.getWidth() / 2
   self.play.h = button_height
   self.play.x = -400
   self.play.y = 140
   self.play_animation = Tween.new(
      self.play,
      "x",
      (love.graphics.getWidth() / 2) - (self.play.w / 2),
      0.2
   )

   self.quit = Button.new("Quit", function()
      love.event.quit()
   end)

   self.quit.w = love.graphics.getWidth() / 2
   self.quit.h = button_height
   self.quit.x = love.graphics.getWidth() + 400
   self.quit.y = 220

   self.quit_animation = Tween.new(
      self.quit,
      "x",
      (love.graphics.getWidth() / 2) - (self.quit.w / 2),
      0.2
   )
end

function Menu:update(dt)
   self.title:update(dt)
   self.title_animation:update(dt)
   self.play:update(dt)
   self.play_animation:update(dt)
   self.quit:update(dt)
   self.quit_animation:update(dt)
end

function Menu:render()
   self.title:render()
   self.play:render()
   self.quit:render()
end

return Menu
