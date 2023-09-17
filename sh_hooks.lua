function PLUGIN:PlayerDeath(ply, _, _)
    if IsValid(ply.Turret) then
        ply.Turret:Remove()
    end
end

function PLUGIN:PlayerChangedTeam(ply, _, _)
    if IsValid(ply.Turret) then
        ply.Turret:Remove()
    end
end
