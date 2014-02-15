local originaldmgmixin = DamageMixin.DoDamage
function DamageMixin:DoDamage(damage, target, point, direction, surface, altMode, showtracer)
	if Server and GetGamerules():GetGameStarted() then
	
		local weapon
	
		if self:isa("Player") then
			attacker = self
		elseif self:GetParent() and self:GetParent():isa("Player") then
			attacker = self:GetParent()
			weapon = self:GetTechId()
		elseif HasMixin(self, "Owner") and self:GetOwner() and self:GetOwner():isa("Player") then
			attacker = self:GetOwner()
			
			if self.techId ~= nil and self.techId > 1 then
				weapon = self:GetTechId()
			end

			// Map to their proper weapons so we don't need to perform voodoo magic
			local mapname = self:GetMapName()
			
			if mapname == Spit.kMapName then
				weapon = kTechId.Spit
			elseif mapname == Grenade.kMapName then
				weapon = kTechId.GrenadeLauncher
			elseif mapname == Flame.kMapName then
				weapon = kTechId.Flamethrower
			elseif mapname == ClusterGrenade.kMapName or mapname == ClusterFragment.kMapName then
				weapon = kTechId.ClusterGrenade
			elseif mapname == NerveGasCloud.kMapName then
				weapon = kTechId.GasGrenade
			elseif mapname == PulseGrenade.kMapName then
				weapon = kTechId.PulseGrenadeProjectile
			elseif mapname == SporeCloud.kMapName then
				weapon = kTechId.Spores
			elseif mapname == Shockwave.kMapName then
				weapon = kTechId.Stomp
			elseif mapname == DotMarker.kMapName then
				weapon = kTechId.BileBomb
			elseif mapname == WhipBomb.kMapName then
				weapon = kTechId.Whip
			elseif weapon == nil then
				weapon = 1
			end
			//Print(weapon .. " " .. self:GetMapName())
			
		else 
			// Don't be silly, if we return here something won't do damage (apparently ARCs :D)
			return originaldmgmixin(self, damage, target, point, direction, surface, altMode, showtracer)
		end
		
		// Secondary attack on alien weapons (lerk spikes, gorge healspray)
		if self.secondaryAttacking or self.shootingSpikes then
			weapon = attacker:GetActiveWeapon():GetSecondaryTechId()
		end
		
        local armorUsed = 0
        local healthUsed = 0
        local damageDone = 0
		
        local damageType = kDamageType.Normal
        if self.GetDamageType then
            damageType = self:GetDamageType()
        elseif HasMixin(self, "Tech") then
            damageType = LookupTechData(self:GetTechId(), kTechDataDamageType, kDamageType.Normal)
        end
		
		if target and HasMixin(target, "Live") and damage > 0 and GetAreEnemies(attacker, target) then
			
			damageDone, armorUsed, healthUsed = GetDamageByType(target, attacker, self, damage, damageType, point)

			// To maintain compatibility and not require the server component, we hijack the damage message
			// posx has to be either 1.0 or 0.0 and posz will always be kHitEffectMaxPosition-1 so we can detect it
			local msg = { }
			msg.amount = healthUsed+(armorUsed)*2
			msg.target = (target and target:GetId()) or Entity.invalidId
			msg.posx = ConditionalValue(target:isa("Player"), 1, 0)
			msg.posy = weapon
			msg.posz = kHitEffectMaxPosition-1
			Server.SendNetworkMessage(attacker, "Damage", msg, false)
		end
	end
	// Now we send the actual damage message
	return originaldmgmixin(self, damage, target, point, direction, surface, altMode, showtracer)
end
