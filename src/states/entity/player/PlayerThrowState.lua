PlayerThrowState = Class{__includes = BaseState}

function PlayerThrowState:init(player, dungeon)
    self.entity= player
    self.dungeon = dungeon

    self.entity.offSetY = 5
    self.entity.offSetX = 0

    self.entity:changeAnimation('throw-' .. self.entity.direction)

end

function PlayerThrowState:enter(params)
    --Insert audio here

    self.entity.currentAnimation:refresh()
end

function PlayerThrowState:update(dt)
    local carriedObject = self.entity.carriedObject


    -- after doing the throw animation cycle go back to idle state
    if self.entity.currentAnimation.timesPlayed > 0 then
        self.entity.currentAnimation.timesPlayed = 0

    if self.entity.carriedObject ~= nil then
        carriedObject.x = self.entity.x
        carriedObject.y  = self.entity.y + 8
        
        self.entity:throwObject(self.entity.carriedObject, self.dungeon.currentRoom, self.entity.direction)
    end


        self.entity:changeState('idle')
    end


end 

function PlayerThrowState:render()
    local anim = self.entity.currentAnimation
    local carriedObject = self.entity.carriedObject

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
    

    if carriedObject ~= nil then
        love.graphics.draw(gTextures[carriedObject.texture], gFrames[carriedObject.texture][(carriedObject.states[carriedObject.state].frame or carriedObject.frame)],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.height + 16 ))
    end

    -- Remember ot add debug stuff
end