
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
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT,WINDOW_WIDTH, WINDOW_HEIGHT, winOptions);
end

love.draw = function()
	push:apply('start');
	love.graphics.printf('Hello',0 ,VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center' );
	push:apply('end');
end


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
