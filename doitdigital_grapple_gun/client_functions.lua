-- Function to check if the player is dead
-- @return (boolean) - Returns true if the player is dead
function IsDead()
    if IsEntityDead(PlayerPedId()) then
        return true
    end

    return false
end