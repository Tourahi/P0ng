
Binocles = require('Binocles');
local push  = require('push');

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


-- Players conf
player1Score = 0;
player2Score = 0;
player1Y = 20;
player2Y = VIRTUAL_HEIGHT - 50;

-- Ball conf
ballX = VIRTUAL_WIDTH / 2 - 2;
ballY = VIRTUAL_HEIGHT / 2 - 2;
ballDX = math.random(2) == 1 and 100 or -100;
ballDY = math.random(-50, 50);

love.load = function()
	Binocles();
	love.graphics.setDefaultFilter('nearest', 'nearest');
	smallF = love.graphics.newFont('font.ttf', 8);
	bigF = love.graphics.newFont('font.ttf', 32);

	love.graphics.setFont(smallF);
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, winOptions);
	gameState = 'start';
	Binocles:watch("ballDX", function() return ballDX end);
	Binocles:watch("ballDY", function() return ballDY end);
end

love.update = function(dt)
	Binocles:update(dt);
	if love.keyboard.isDown('w') then
		player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt);
	elseif love.keyboard.isDown('s') then
		player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt);
	end

	if love.keyboard.isDown('up') then
		player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt);
	elseif love.keyboard.isDown('down') then
		player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt);
	end

	if gameState == 'play' then
		ballX = ballX + ballDX * dt;
		ballY = ballY + ballDY * dt;
	end
end

love.draw = function()
	push:apply('start');
	love.graphics.clear(40/255, 45/255, 52/255, 255/255);
	love.graphics.printf('Hello',0 , 20, VIRTUAL_WIDTH, 'center' );

	-- left paddle
	love.graphics.rectangle('fill', 10, player1Y, 5, 20);

	-- right paddle
	love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20);

	-- render ball (center)
	love.graphics.rectangle('fill', ballX, ballY, 4, 4);
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
					ballX = VIRTUAL_WIDTH / 2 - 2
					ballY = VIRTUAL_HEIGHT / 2 - 2
					ballDX = math.random(2) == 1 and 100 or -100;
					ballDY = math.random(-50, 50);
				end
			end
		end
end
