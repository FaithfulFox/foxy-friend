local Label = require("src.ui.widgets.label")
local Button = require("src.ui.widgets.button")

local Menu = {}

function Menu:enter()
	self.title = Label.new("Foxy Friends")
	-- self.title.x = (love.graphics.getWidth() / 2)
	self.title.y = 20

	self.play = Button.new(
		"Play",
		function() UI:push(require("src.ui.screens.game")) end
	)
	self.play.y = 40

	self.quit = Button.new("Quit", function() love.event.quit() end)

	-- self.quit.x = (love.graphics.getWidth() / 2)
	self.quit.y = 60
end

function Menu:update(dt)
	self.title:update(dt)
	self.play:update(dt)
	self.quit:update(dt)
end

function Menu:render()
	self.title:render()
	self.play:render()
	self.quit:render()
end

return Menu
