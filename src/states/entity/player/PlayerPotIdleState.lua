
PlayerPotIdleState = Class{__includes = BaseState}

function PlayerPotIdleState:init(player, dungeon)
	self.player = player
	--self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
    self.player:changeAnimation('pot-idle-' .. self.player.direction)
end

function PlayerPotIdleState:enter(params)
    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

end

function PlayerPotIdleState:update(dt)

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
       self.player:changeState('pot-walk')
    end


    if love.keyboard.isDown('return') then
        -- TODO I need to change it idle state ot thte trhow state
        self.player:changeState('throw')
    end 
end

function PlayerPotIdleState:render()
    local anim = self.player.currentAnimation 
    local carriedObject = self.player.carriedObject


    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.height + 16))
    
    if carriedObject ~= nil then
        love.graphics.draw(gTextures[carriedObject.texture], gFrames[carriedObject.texture][(carriedObject.states[carriedObject.state].frame or carriedObject.frame)],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.height + 16 ))
    end 

    if DEBUG then
        love.graphics.setColor(255, 0, 255, 255)
        love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
        love.graphics.setColor(255, 255, 255, 255)
    end
end