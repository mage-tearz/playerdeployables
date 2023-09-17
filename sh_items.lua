local TurretItem = {}

TurretItem.UniqueID = "deployables_turret"
TurretItem.Name = "Overwatch Automated Sterilizer"
TurretItem.Desc =  "A heavy machine made from a synthetic alien metal, capable of automatically firing Mk.III Pulse ammunition."
TurretItem.Category = "Deployables"
TurretItem.Model = Model("models/combine_turrets/floor_turret_gib1.mdl")
TurretItem.FOV = 16.180515759312
TurretItem.CamPos = Vector(-55.931232452393, -27.507164001465, 41.604583740234)
TurretItem.NoCenter = true
TurretItem.Weight = 5

TurretItem.Droppable = true
TurretItem.DropOnDeath = true
TurretItem.DropOnDeathIfRestricted = false
TurretItem.DroppableIfRestricted = false

TurretItem.Illegal = true
TurretItem.CanStack = false

TurretItem.UseName = "Deploy"
TurretItem.UseWorkBarTime = 2.5
TurretItem.UseWorkBarFreeze = true
TurretItem.UseWorkBarName = "Deploying turret..."
TurretItem.UseWorkBarSound = "npc/scanner/cbot_discharge1.wav"
function TurretItem:OnUse(ply)
  	    if IsValid(ply.Turret) then
            ply.Turret:Remove()
        end

        ply.Turret = ents.Create( "npc_turret_floor" )
        ply.Turret:SetPos( ply:GetPos() + Vector(0,50,5) )
        ply.Turret:SetAngles(ply:EyeAngles())
        ply.Turret:Spawn()
        ply.Turret:EmitSound("npc/scanner/scanner_siren1.wav",100,98,0.80,CHAN_AUTO)

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
            PrintTable(friends:GetPlayers())

        end
        local grid = math.Round(ply:GetPos().x / 100).."/"..math.Round(ply:GetPos().y / 100)
        ply:SendCombineMessage("STERILIZER DEPLOYED AT GRID "..grid..".", Color(255, 100, 0))
    return true
end
impulse.RegisterItem(TurretItem)
