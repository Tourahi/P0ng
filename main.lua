
Binocles = require('Binocles');
class = require('30log');
local push  = require('push');
local Player = require('Player');
local Ball = require('Ball');

math.randomseed(os.time());

WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 432;
VIRTUAL_HEIGHT = 243;

local PADDLE_SPEED = 200;

local winOptions = {
	fullscreen = false,
	resizable = false,
	vsync = true
};

local smallF; -- small font 8
local bigF; -- big fount 32



love.load = function()
	Binocles();
	love.window.setTitle("Pong");
	love.graphics.setDefaultFilter('nearest', 'nearest');
	smallF = love.graphics.newFont('font.ttf', 8);
	bigF = love.graphics.newFont('font.ttf', 32);

	love.graphics.setFont(smallF);
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, winOptions);
  player1 = Player("player1",10, 30, 5, 20);
  player2 = Player("player2",VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20);
  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4);
	gameState = 'start';
	Binocles:watch("FPS", function() return love.timer.getFPS() end);
end

love.update = function(dt)
	Binocles:update(dt);

	if gameState == 'play' then

		if ball:collides(player1) then
			ball.dx = -ball.dx * 1.03;
			ball.x = player1.x + 5;

			if ball.dy < 0 then
				ball.dy = -math.random(10, 150);
			else
				ball.dy = math.random(10, 150);
			end
		end

		if ball:collides(player2) then
			ball.dx = -ball.dx * 1.03;
			ball.x = player2.x - 4;

			if ball.dy < 0 then
				ball.dy = -math.random(10, 150);
			else
				ball.dy = math.random(10, 150);
			end
		end

		if ball.y <= 0 then
			ball.y = 0;
			ball.dy = -ball.dy;
		end

		if ball.y >= VIRTUAL_HEIGHT - 4 then
			ball.y = VIRTUAL_HEIGHT - 4;
			ball.dy = -ball.dy;
		end
	end

	if love.keyboard.isDown('w') then
		player1.dy = -PADDLE_SPEED;
	elseif love.keyboard.isDown('s') then
		player1.dy = PADDLE_SPEED;
  else
    player1.dy = 0;
	end

	if love.keyboard.isDown('up') then
		player2.dy = -PADDLE_SPEED;
	elseif love.keyboard.isDown('down') then
		player2.dy = PADDLE_SPEED;
  else
    player2.dy = 0;
	end

	if gameState == 'play' then
    ball:update(dt);
	end

  player1:update(dt);
  player2:update(dt);
end

love.draw = function()

	push:apply('start');
	love.graphics.clear(40/255, 45/255, 52/255, 255/255);
	love.graphics.printf('Score',0 , 20, VIRTUAL_WIDTH, 'center' );
	love.graphics.setFont(bigF);
	love.graphics.print(tostring(player1.score), VIRTUAL_WIDTH / 2 - 50,
			VIRTUAL_HEIGHT / 25);
	love.graphics.print(tostring(player2.score), VIRTUAL_WIDTH / 2 + 30,
			VIRTUAL_HEIGHT / 25);
	love.graphics.setFont(smallF);

  player1:draw();
  player2:draw();
  ball:draw();
	Binocles:draw();
	push:apply('end');
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit();
		else if key == 'return' or key == 'enter' then
			if gameState == 'start' then
					gameState = 'play';
			elseif gameState == 'play' then
					gameState = 'start';
          ball:reset();
				end
			end
		end
end
