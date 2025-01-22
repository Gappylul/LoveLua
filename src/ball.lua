local Object = require("classic")

Ball = Object:extend()

function Ball:new()
    self.x = 400
    self.y = 300
    self.radius = 20
    self.speed = 200
    self.dx = 1
    self.dy = 1
    self.elasticity = 1.1
    self.points = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * self.speed * dt
    self.y = self.y + self.dy * self.speed * dt

    -- Bounce off walls
    if self.x - self.radius <= 0 or self.x + self.radius >= love.graphics.getWidth() then
        self.dx = -self.dx
    end

    if self.y - self.radius <= 0 or self.y + self.radius >= love.graphics.getHeight() then
        self.dy = -self.dy
    end
end

function Ball:checkCollision(paddle)
    -- Check if the ball is colliding with the paddle
    if self.x + self.radius > paddle.x and self.x - self.radius < paddle.x + paddle.width and
            self.y + self.radius > paddle.y and self.y - self.radius < paddle.y + paddle.height then

        -- Determine if the collision is more horizontal or vertical
        local ballCenterX = self.x
        local ballCenterY = self.y
        local paddleCenterX = paddle.x + paddle.width / 2
        local paddleCenterY = paddle.y + paddle.height / 2

        local diffX = ballCenterX - paddleCenterX
        local diffY = ballCenterY - paddleCenterY

        if math.abs(diffX) > math.abs(diffY) then
            -- Horizontal collision (left or right of paddle)
            if diffX > 0 then
                self.x = paddle.x + paddle.width + self.radius -- Move ball to the right
                self.points = self.points + 1
            else
                self.x = paddle.x - self.radius -- Move ball to the left
                self.points = self.points + 1
            end
            self.dx = -self.dx
        else
            -- Vertical collision (top or bottom of paddle)
            if diffY > 0 then
                self.y = paddle.y + paddle.height + self.radius -- Move ball below the paddle
                self.points = self.points + 1
            else
                self.y = paddle.y - self.radius -- Move ball above the paddle
                self.points = self.points + 1
            end
            self.dy = -self.dy
        end

        -- Increase speed slightly after collision
        self.speed = self.speed * self.elasticity
    end
end

