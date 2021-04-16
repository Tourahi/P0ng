
Binocles = require('Binocles');
local push  = require('push');

WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

local winOptions = {
	fullscreen = false,
	resizable = false,
	vsync = true
};

love.load = function()
	love.graphics.setDefaultFilter('nearest', 'nearest');
	local retroF = love.graphics.newFont('font.ttf', 8);
	love.graphics.setFont(retroF);
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, winOptions);
end

love.draw = function()
	push:apply('start');
	love.graphics.clear(40/255, 45/255, 52/255, 255/255);
	love.graphics.printf('Hello',0 , 20, VIRTUAL_WIDTH, 'center' );

	-- left paddle
	love.graphics.rectangle('fill', 10, 30, 5, 20);

	-- right paddle
	love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20);


	push:apply('end');
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
