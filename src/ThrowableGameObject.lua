ThrowableGameObject = Class{_includes = GameObject}

function ThrowableGameObject:init(def, x, y, room)
    self.onThrow = def.onThrow
    self.projectile = false
    self.distance = 0
    self.maxDistance = 64
    self.room = room
    self.dx = 0
    self.dy = 0

    GameObject.init(self, def, x ,y)

    self.hitbox = Hitbox(self.x + 4, self.y + 4, self.width - 8, self.height - 8)
end

function ThrowableGameObject:update(dt)

    if self.projectile then
        local objectCollision = false

        for k, object in pairs(self.room.objects) do
            if object.solid and GameObject.collides(self, object) then
                objectCollision = true
            end 
        end

        if self:checkWallCollision() then
            objectCollision = true
        end

        if objectCollision or self.distance > self.maxDistance then
            self:destroy()
        end

        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
        self.distance = self.distance + OBJECT_MOVE_SPEED *dt
    end

    self.hitbox = Hitbox(self.x + 4, self.y + 4, self.width - 8, self.height - 8)


--current no logic and shoudl just fly in the direction I am facing
    --[[
    self.x = self.x + self.dx *dt
    self.y = self.y + self.dy *dt
    self.distance = self.distance + OBJECT_MOVE_SPEED * dt
    self.hitbox = Hitbox(self.x + 4, self.y + 4, self.width - 8, self.height - 8)
    ]]--

end

function ThrowableGameObject:render(adjacentOffsetX, adjacentOffsetY)
    GameObject.render(self, adjacentOffsetX, adjacentOffsetY)

end

function ThrowableGameObject:destroy()
    self.state = 'broken'
    self.projectile = false
    self.dx = 0
    self.dy = 0
end

function ThrowableGameObject:lift()
    self.state = 'carried'
end

function ThrowableGameObject:throw(self, room, dx ,dy)
    self.projectile = true
    --Removed onThrow because for some reason it isn't being called
    --self.onThrow(self, room, dx, dy)

    self.dx = dx
    self.dy = dy
    table.insert(room.projectiles, self)

end

function ThrowableGameObject:checkWallCollision()
    -- check for all the collisions in 
    local rightEdge = VIRTUAL_WIDTH - TILE_SIZE*2 - self.width
    local leftEdge = MAP_RENDER_OFFSET_X + TILE_SIZE
    local topEdge = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height/2
    local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE*2


    if self.x < leftEdge or self.x > rightEdge or self.y < topEdge or self.y > bottomEdge then
        return true 
    end 
    return false
end