
PlayerPotWalkState = Class{__includes = EntityWalkState}


function PlayerPotWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPotWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
	    self.entity:changeAnimation('pot-walk-left')
    elseif love.keyboard.isDown('right') then
	    self.entity.direction = 'right'
	    self.entity:changeAnimation('pot-walk-right')
    elseif love.keyboard.isDown('up') then
	    self.entity.direction = 'up'
	    self.entity:changeAnimation('pot-walk-up')
    elseif love.keyboard.isDown('down') then
	    self.entity.direction = 'down'
	    self.entity:changeAnimation('pot-walk-down')
    else
        self.entity:changeState('pot-idle')
    end

    if love.keyboard.wasPressed('return') then
        self.entity:changeState('throw')
    end

    EntityWalkState.update(self,dt)
end


function PlayerPotWalkState:render()

    local anim = self.entity.currentAnimation
    local carriedObject = self.entity.carriedObject

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    if carriedObject ~= nil then
        love.graphics.draw(gTextures[carriedObject.texture], gFrames[carriedObject.texture][(carriedObject.states[carriedObject.state].frame or carriedObject.frame)],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.height + 16 ))
    end

    if DEBUG then
        love.graphics.setColor(255, 0, 255, 255)
        love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
        love.graphics.setColor(255, 255, 255, 255)
    end 
end