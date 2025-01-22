local Object = require("classic")

Paw = Object:extend()

function Paw:new(x)
    self.x = x
    self.y = 480
    self.width = 50
    self.height = 120
    self.speed = 250
end

function Paw:move(dt, leftKey, rightKey, minX, maxX)
    if love.keyboard.isDown(leftKey) and self.x > minX then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown(rightKey) and self.x + self.width < maxX then
        self.x = self.x + self.speed * dt
    end
end
