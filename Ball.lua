local Ball = class("Ball", {
  x,
  y,
  width,
  height,
  dx,
  dy
});

Ball.init = function(self, x, y, width, height)
  self.x = x;
  self.y = y;
  self.width = width;
  self.height = height;
  self.dx = math.random(2) == 1 and 100 or -100;
  self.dy = math.random(-50,50);
end

Ball.reset = function(self)
  self.x = VIRTUAL_WIDTH / 2 - 2;
  self.y = VIRTUAL_HEIGHT / 2 - 2;
  self.dx = math.random(2) == 1 and 100 or -100;
  self.dy = math.random(-50,50);
end

Ball.update = function(self, dt)
  self.x = self.x + self.dx * dt;
  self.y = self.y + self.dy * dt;
end

Ball.collides = function(self, player)
	if self.x > player.x + player.width or player.x > self.x + self.width then
		return false;
	end

	if self.y > player.y + player.height or player.y > self.y + self.height then
		return false;
	end

	return true;
end


Ball.draw = function(self)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height);
end

return Ball;
