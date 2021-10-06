--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        consumable = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        -- TODO
        type = 'throwable',
        texture = 'tiles',
        projectile = false,
        frame = 14,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'onGround',
        states = {
            ['onGround'] = {
                frame = 14
            },
            ['carried'] = {
                frame = 14
            },
            ['thrown'] = {
                frame = 14
            },
            ['broken'] = {
                frame  = 52
            }
        },

        onThrow = function(self, room, dx, dy)
            self.dx = dx;
            self.dy = dy;
            table.insert(room.projectiles, self)
        end
    },
    ['heart']  = {
        -- TODO make it so i can health the player
        type = 'hearts',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        consumable = true,
        defaultState = 'consumable',
        states = {
            ['consumable'] = {
                frame = 5
            }
        }
    }

}