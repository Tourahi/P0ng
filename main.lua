
Binocles = require('Binocles');
class = require('30log');
local push  = require('push');
local Player = require('Player');
local Ball = require('Ball');

math.randomseed(os.time());

local WIN_SCORE = 2;

WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 432;
VIRTUAL_HEIGHT = 243;

local PADDLE_SPEED = 200;

local winOptions = {
	fullscreen = false,
	resizable = true,
	vsync = true
};

local smallF; -- small font 8
local bigF; -- big fount 32

--
playerServing = 1;
winner = 0;



love.load = function()
	Binocles();
	love.window.setTitle("Pong");
	love.graphics.setDefaultFilter('nearest', 'nearest');

	smallF = love.graphics.newFont('font.ttf', 8);
	midF = love.graphics.newFont('font.ttf', 16);
	bigF = love.graphics.newFont('font.ttf', 32);

	love.graphics.setFont(smallF);
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, winOptions);
  player1 = Player("player1",10, 30, 5, 20, {r = 0 , g = 0, b = 0});
  player2 = Player("player2",VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20, {r = 144 , g = 0, b = 32});
  ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4);



	gameState = 'start';
	Binocles:watch("FPS", function() return love.timer.getFPS() end);
end

love.update = function(dt)
	Binocles:update(dt);

	if gameState == 'serve' then
		ball.dy = math.random(-50, 50);
		if playerServing == 1 then
			ball.dx = math.random(140, 200);
		else
			ball.dx =  -math.random(140, 200);
		end


	elseif gameState == 'play' then

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

			-- Score updating
		if ball.x < 0 then
			playerServing = 1;
			player2.score = player2.score + 1;

			if player2.score == WIN_SCORE then
				winner = 2;
				gameState = 'done';
			else
				gameState = 'serve';
				ball:reset();
			end
		end

		if ball.x > VIRTUAL_WIDTH then

			playerServing = 2;
			player1.score = player1.score + 1;

			if player1.score == WIN_SCORE then
				winner = 1;
				gameState = 'done';
			else
				gameState = 'serve';
				ball:reset();
			end
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

function drawScore(lg)
	lg.setFont(smallF);
	lg.printf('Score',0 , 60, VIRTUAL_WIDTH, 'center' );
	lg.setFont(bigF);
	lg.print(tostring(player1.score), VIRTUAL_WIDTH / 2 - 50,
			VIRTUAL_HEIGHT / 5);
	lg.print(tostring(player2.score), VIRTUAL_WIDTH / 2 + 30,
			VIRTUAL_HEIGHT / 5);
end

love.draw = function()
	local lg= love.graphics;
	push:apply('start');
	lg.clear(83/255, 86/255, 90/255, 255/255);

	if gameState == 'start' then
		lg.setFont(smallF);
		lg.printf('Welcome to Pong',0 ,10 , VIRTUAL_WIDTH, 'center');
		lg.printf('Left is P1 (w,s) :: Right is P2 (up,down)',0 ,20 , VIRTUAL_WIDTH, 'center');
		lg.printf('Press Enter to play !!',0 ,30 , VIRTUAL_WIDTH, 'center');
	elseif gameState == 'serve' then
		lg.setFont(smallF);
		lg.printf('Player ' .. tostring(playerServing) .. "'s serve!",
			0, 10, VIRTUAL_WIDTH, 'center');
		lg.printf('Press Enter to serve !!',0 ,20 , VIRTUAL_WIDTH, 'center');

	elseif gameState == 'done' then
		lg.setFont(midF);
		lg.printf('Player ' .. tostring(winner) .. ' wins!'
		 , 0, 10, VIRTUAL_WIDTH, 'center');
		 lg.setFont(smallF);
		 lg.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center');
	end


	drawScore(lg);

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
						gameState = 'serve';
				elseif gameState == 'serve' then
						gameState = 'play';
				elseif gameState == 'done' then
					gameState = 'serve';
					ball:reset();
					player1.score = 0;
					player2.score = 0;

					if winner == 1 then
						playerServing = 2;
					else
						playerServing = 1;
					end

				end
			end
		end
end

function love.resize(w, h)
	push:resize(w,h);
end
