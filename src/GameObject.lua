--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    -- Whether it acts as a consumable
    self.consumable = def.consumable

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- default empty collision callback
    self.onCollide = function() end

    -- default empty on consume call back
    --self.onConsume = def.onConsume
    self.onConsume = function(entity, objects, k) end


    self.onThrow = function() end
    --self.hitbox = Hitbox(self.x + 2, self.y + 2, self.width - 4, self.height - 4)
end

function GameObject:update(dt)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)

    if DEBUG then
        love.graphics.setColor(255, 0, 255, 255)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function GameObject:collides(target)
    return not (self.hitbox.x + self.hitbox.width < target.x or self.hitbox.x > target.x + target.width or 
                self.hitbox.y + self.hitbox.height < target.y or self.hitbox.y > target.y + target.height)
end
