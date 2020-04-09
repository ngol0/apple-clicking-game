function love.load()
  --Create table for apple image
  button = {}
  button.object = love.graphics.newImage('apple.png')
  button.x = 100
  button.y = 100
  --button.size = 50

  --Score, timer and gameState variables
  score = 0
  timer = 10
  gameState = 1

  --Set font to pixel art
  myFont = love.graphics.newFont("font.ttf",40)
end

function love.update(dt)
  --Counting down
  if gameState == 2 then
    if timer > 0 then
      timer = timer - dt
    end

    --If timer = -0, set back to 0 and go to end of game screen
    if timer < 0 then
      timer = 0
      gameState = 3
    end
  end
end

function love.draw()
  --Draw apple on game play stage
  if gameState == 2 then
    --love.graphics.setColor(0,70,60)
    --love.graphics.circle("fill", button.x, button.y, button.size)
    love.graphics.draw(button.object, button.x, button.y)
  end

  --Print score and timer
  love.graphics.setFont(myFont)
  love.graphics.setColor(255,255,255)
  love.graphics.print("Score: " .. score)
  love.graphics.print("Time: " .. math.ceil(timer), 600, 0)

  --Print on main menu
  if gameState == 1 then
    love.graphics.printf("Click anywhere to play!", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
  end

  --Print on end of game menu
  if gameState == 3 then
    love.graphics.printf("Time out!", 0, love.graphics.getHeight()/2 - 30, love.graphics.getWidth(), "center")
    love.graphics.printf("Click anywhere to play again", 0, love.graphics.getHeight()/2 + 10, love.graphics.getWidth(), "center")
  end
end

--If left mouse is pressed
function love.mousepressed(x, y, b, isTouch)
  --Main menu screen
  if gameState == 1 then
    gameState = 2
  end

  --End of game screen
  if gameState == 3 then
    gameState = 2
    score = 0
    timer = 10
  end

  --Gameplay screen
  if b == 1 and gameState == 2
  --If image is pressed
  and x >= button.x and x < button.x + button.object:getWidth()
  and y >= button.y and y < button.y + button.object:getHeight() then
    --if distance(button.x, button.y, love.mouse.getX(), love.mouse.getY()) < button.size then
      score = score + 1
      button.x = math.random(0, love.graphics.getWidth() - button.object:getWidth())
      button.y = math.random(0, love.graphics.getHeight() - button.object:getHeight())
    --end
  end
end

--function distance(x1, y1, x2, y2)
  --return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
--end
