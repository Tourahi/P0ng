
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
	love.graphics.setDefaultFilter('nearest', 'nearest');
	smallF = love.graphics.newFont('font.ttf', 8);
	bigF = love.graphics.newFont('font.ttf', 32);

	love.graphics.setFont(smallF);
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, winOptions);
  player1 = Player(10, 30, 5, 20);
  player2 = Player(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20);
  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4);
	gameState = 'start';
end

love.update = function(dt)
	Binocles:update(dt);
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
		player2.dy = -PADDLE_SPEED;
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
	love.graphics.printf('Hello',0 , 20, VIRTUAL_WIDTH, 'center' );

  player1:draw();
  player2:draw();
  ball:draw();

	push:apply('end');

  Binocles:draw();
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
