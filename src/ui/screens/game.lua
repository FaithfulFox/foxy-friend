local Canvas = require("src.ui.widgets.canvas")

local Game = {}

function Game:enter() self.pet_window = Canvas.new({ 0.7, 0.2, 0.03, 1.0 }) end

function Game:update(dt) self.pet_window:update(dt) end

function Game:render() self.pet_window:render() end

return Game
