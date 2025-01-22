local function createBall()
    return {
        x = 400,
        y = 300,
        radius = 20,
        speed = 200,
        dx = 1,
        dy = 1,
        elasticity = 1.1
    }
end

return createBall