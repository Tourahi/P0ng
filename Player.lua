local Player = class("Player", {
	name,
  x,
  y,
  width,
  height,
  dy,
	score = 0
});

Player.init = function(self, name, x, y, width, height)
  self.name = name;
	self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.dy = 0
end


Player.update = function(self, dt)
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * dt);
  else
    self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt);
  end
end

Player.draw = function(self)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height);
end



return Player;
