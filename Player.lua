local Player = class("Player", {
	name,
  x,
  y,
  width,
  height,
  dy,
	score = 0,
	color
});

Player.init = function(self, name, x, y, width, height, color)
  self.name = name;
	self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.dy = 0
	self.color = color;
end


Player.update = function(self, dt)
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * dt);
  else
    self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt);
  end
end

Player.draw = function(self)
	love.graphics.push('all');
	love.graphics.setColor(self.color.r/255,self.color.g/255,self.color.b/255,1);
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height);
	love.graphics.pop();
end



return Player;
