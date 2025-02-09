TOOL.Category = "NPC Control"
TOOL.Name = "#tool.npc_viewcam.name"
TOOL.Command = nil
TOOL.ConfigName = ""

if(CLIENT) then
	language.Add("tool.npc_viewcam.name","NPC Viewcam")
	language.Add("tool.npc_viewcam.desc","Create a camera attached to a NPC.")
	language.Add("tool.npc_viewcam.0","Left-Click on a NPC to enter camera mode. Use key to end camera mode.")

	function TOOL.BuildCPanel(pnl)
		pnl:Help("#tool.npc_viewcam.0")
	end
end

function TOOL:LeftClick(tr)
	if(CLIENT) then return true end
	if(tr.Entity:IsValid() && tr.Entity:IsNPC()) then
		local ent = ents.Create("obj_viewcam")
		ent:SetEntityOwner(self:GetOwner())
		ent:SetTarget(tr.Entity)
		ent:SetPos(tr.Entity:GetPos() +tr.Entity:OBBCenter() +Vector(0,0,tr.Entity:OBBMaxs().z *0.5))
		ent:SetParent(tr.Entity)
		ent:Spawn()
		ent:Activate()
		if(tr.Entity:LookupAttachment("possession_cam") > 0) then
			ent:Fire("SetParentAttachment","possession_cam",0)
		end
		ent:Start()
		return true
	end
	return false
end

function TOOL:RightClick(trace)
end
