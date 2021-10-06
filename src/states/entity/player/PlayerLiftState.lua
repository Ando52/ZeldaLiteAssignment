
PlayerLiftState = Class{__includes = BaseState}

function PlayerLiftState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    self.player.offsetY = 5
    self.player.offsetX = 0

    local direction = self.player.direction
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y + self.player.height
    end

    self.liftHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)


    self.player:changeAnimation('pot-lift-' .. self.player.direction)
end

function PlayerLiftState:enter(params)
    self.player.currentAnimation:refresh() 
end

function PlayerLiftState:update(dt)

    -- if we go through entire animation once the go to pot-idle state
    if self.player.currentAnimation.timesPlayed > 0 then

        for k, object in pairs(self.dungeon.currentRoom.objects) do
            if object.type == 'throwable' and object.solid then
                if self.liftHitbox:collides(object) then
                    self.player:pickObject(object) 
                    table.remove(self.dungeon.currentRoom.objects, k)
                    self.player:changeState('pot-idle')
                    return
                end
            end
        end

        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('idle')
    end 
end 

function PlayerLiftState:render()
    
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    if DEBUG then
        love.graphics.setColor(255, 0, 255, 255)
        love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
        love.graphics.rectangle('line', self.liftHitbox.x, self.liftHitbox.y, self.liftHitbox.width, self.liftHitbox.height)
        love.graphics.setColor(255, 255, 255, 255)
    end

end 