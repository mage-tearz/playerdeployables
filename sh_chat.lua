local spawnTurretCommand = {
    description = "Spawns a turret.",
    onRun = function(ply, arg, rawText) 
        
        if IsValid(ply.Turret) then
            ply.Turret:Remove()
        end

        local tr = ply:GetEyeTrace()
        ply.Turret = ents.Create( "npc_turret_floor" )
        ply.Turret:SetPos( tr.HitPos + Vector(100, 0, 10) )
        ply.Turret:SetAngles(Angle(0,180,0))
        ply.Turret:Spawn()

        local friends = RecipientFilter(false)
        --friends:AddAllPlayers()
        --friends:RemoveRecipientsByTeam(ply:Team())
        friends:AddRecipientsByTeam(ply:Team())
        
        if ply:Team() == TEAM_OTA then
            friends:AddRecipientsByTeam(TEAM_CP)
        elseif ply:Team() == TEAM_CP then
            friends:AddRecipientsByTeam(TEAM_OTA)
        end

        for i, v in ipairs(friends:GetPlayers()) do

            ply.Turret:AddEntityRelationship( v, D_LI, 99 )
            --PrintTable(friends:GetPlayers()) -- for debugging

        end
        ply:Notify("Turret deployed!")

    end
}
impulse.RegisterChatCommand("/turret", spawnTurretCommand)

local removeTurretCommand = {
    description = "Removes your turret.",
    onRun = function(ply, arg, rawText)
        if IsValid(ply.Turret) then
            ply.Turret:Remove()
        end
    end
}
impulse.RegisterChatCommand("/turretremove", removeTurretCommand)
