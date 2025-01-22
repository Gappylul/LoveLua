local love = require("love")
local createPaw = require("paw")
local createBall = require("ball")

function love.load()
    love.window.setMode(800, 600, { resizable = false })

    paw1 = createPaw()
    paw2 = createPaw()

    paw2.x = love.graphics.getWidth() - paw2.width - 100

    ball = createBall()
end

function love.draw()
    love.graphics.rectangle("fill", paw1.x, paw1.y, paw1.width, paw1.height)
    love.graphics.rectangle("fill", paw2.x, paw2.y, paw2.width, paw2.height)

    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

function love.update(dt)

    -- paws logic
    if love.keyboard.isDown("a") then
        paw1.x = paw1.x - paw1.speed * dt
    elseif love.keyboard.isDown("d") and not paw1.max_distance then
        paw1.x = paw1.x + paw1.speed * dt
    end


    if love.keyboard.isDown("right") then
        paw2.x = paw2.x + paw2.speed * dt
    elseif love.keyboard.isDown("left") and not paw2.max_distance then
        paw2.x = paw2.x - paw2.speed * dt
    end

    if paw1.x >= love.graphics.getWidth() - paw1.width - 400 then
        paw1.max_distance = true
    else
        paw1.max_distance = false
    end

    if paw2.x <= 400 then
        paw2.max_distance = true
    else
        paw2.max_distance = false
    end

    -- ball logic
    ball.x = ball.x + ball.dx * ball.speed * dt
    ball.y = ball.y + ball.dy * ball.speed * dt

    if ball.x - ball.radius <= 0 or ball.x + ball.radius >= love.graphics.getWidth() then
        ball.dx = -ball.dx
        ball.speed = ball.speed * ball.elasticity
    end

    if ball.y - ball.radius <= 0 or ball.y + ball.radius >= love.graphics.getHeight() then
        ball.dy = -ball.dy
        ball.speed = ball.speed * ball.elasticity
    end

    if ball.x + ball.radius > paw1.x and ball.x - ball.radius < paw1.x + paw1.width then
        if ball.y + ball.radius > paw1.y and ball.y - ball.radius < paw1.y + paw1.height then
            if ball.x - ball.radius <= paw1.x or ball.x + ball.radius >= paw1.x + paw1.width then
                ball.dx = -ball.dx
                ball.speed = ball.speed * ball.elasticity
            end

            if ball.dy > 0 then
                ball.dy = -ball.dy
            else
                ball.dy = -ball.dy
            end
        end
    end

    if ball.x + ball.radius > paw2.x and ball.x - ball.radius < paw2.x + paw2.width then
        if ball.y + ball.radius > paw2.y and ball.y - ball.radius < paw2.y + paw2.height then
            if ball.x - ball.radius <= paw2.x or ball.x + ball.radius >= paw2.x + paw2.width then
                ball.dx = -ball.dx
                ball.speed = ball.speed * ball.elasticity
            end

            if ball.dy > 0 then
                ball.dy = -ball.dy
            else
                ball.dy = -ball.dy
            end
        end
    end
end