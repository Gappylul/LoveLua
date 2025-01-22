local love = require("love")
local gameOver = false
require("paw")
require("ball")

function love.load()
    love.window.setMode(800, 600, { resizable = false })

    paw1 = Paw(100)
    paw2 = Paw(love.graphics.getWidth() - 150)
    ball = Ball()
end

function love.update(dt)
    if gameOver then
        return
    end

    -- Player movement
    paw1:move(dt, "a", "d", 0, love.graphics.getWidth() / 2)
    paw2:move(dt, "left", "right", love.graphics.getWidth() / 2, love.graphics.getWidth())

    -- Ball movement
    ball:update(dt)

    -- Check for collisions
    ball:checkCollision(paw1)
    ball:checkCollision(paw2)

    -- Check if ball hits the bottom of the screen
    if ball.y + ball.radius >= love.graphics.getHeight() then
        gameOver = true
    end
end

function love.draw()
    -- Draw points
    love.graphics.setFont(love.graphics.newFont(30)) -- Set a larger font size
    love.graphics.printf(ball.points, 0, 20, love.graphics.getWidth(), "center")

    -- Draw paddles
    love.graphics.rectangle("fill", paw1.x, paw1.y, paw1.width, paw1.height)
    love.graphics.rectangle("fill", paw2.x, paw2.y, paw2.width, paw2.height)

    -- Draw ball
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)

    -- Show "GAME OVER" text
    if gameOver then
        love.graphics.setColor(1, 0, 0) -- Red color
        love.graphics.printf("GAME OVER", 0, love.graphics.getHeight() / 2 - 50, love.graphics.getWidth(), "center")
        love.graphics.setColor(1, 1, 1) -- Reset to white
    end
end

function love.keypressed(key)
    if gameOver and key == "space" then
        restartGame()
    end
end

function restartGame()
    gameOver = false

    -- Reset ball
    ball.x = love.graphics.getWidth() / 2
    ball.y = love.graphics.getHeight() / 2
    ball.dx = 1
    ball.dy = 1
    ball.speed = 200
    ball.points = 0

    -- Reset paws
    paw1.x = 100
    paw2.x = love.graphics.getWidth() - paw2.width - 100
end