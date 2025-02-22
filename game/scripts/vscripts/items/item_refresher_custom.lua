LinkLuaModifier("modifier_item_refresher_custom", "items/item_refresher_custom", LUA_MODIFIER_MOTION_NONE)

item_refresher_custom = class({})

function item_refresher_custom:GetIntrinsicModifierName()
	return "modifier_item_refresher_custom"
end

function item_refresher_custom:IsRefreshable()
    return false
end

item_refresher_custom.NotRefresh = 
{
    ["item_refresher_custom"] = true,
    ["item_refresher_shard"] = true,
    ["item_ex_machina"] = true,
    ["item_ex_machina_custom"] = true,
    ["nolik_tech"] = true,
    ["kakashi_sharingan"] = true,
    ["Overlord_spell_14"] = true,
    ["travoman_minefield_sign"] = true,
    ["Vjlink_dudos"] = true,
}

function item_refresher_custom:NotRefresher( item )
    return self.NotRefresh[item:GetName()]
end

function item_refresher_custom:OnSpellStart()
	for i=0, self:GetCaster():GetAbilityCount()-1 do
        local ability = self:GetCaster():GetAbilityByIndex( i )
        if ability and ability:GetAbilityType()~=DOTA_ABILITY_TYPE_ATTRIBUTES and not self:NotRefresher( ability ) then
            ability:RefreshCharges()
            ability:EndCooldown()
        end
    end

    for i=0,5 do
        local item = self:GetCaster():GetItemInSlot(i)
        if item then
            if not self:NotRefresher( item ) then
                item:EndCooldown()
            end
        end
    end

    local item_neutral = self:GetCaster():GetItemInSlot(16)
    if item_neutral then
        if not self:NotRefresher( item_neutral ) then
            item_neutral:EndCooldown()
        end
    end

    self:GetCaster():EmitSound("DOTA_Item.Refresher.Activate")

    local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
end

modifier_item_refresher_custom = class({})
function modifier_item_refresher_custom:IsHidden() return true end
function modifier_item_refresher_custom:IsPurgable() return false end
function modifier_item_refresher_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_refresher_custom:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

function modifier_item_refresher_custom:GetModifierConstantManaRegen()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_mana_regen") end
end

function modifier_item_refresher_custom:GetModifierConstantHealthRegen()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_health_regen") end
end

function modifier_item_refresher_custom:GetModifierPreAttack_BonusDamage()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("damage") end
end

item_refresher_shard_custom = class({})

function item_refresher_shard_custom:IsRefreshable()
    return false
end

item_refresher_shard_custom.NotRefresh = 
{
    ["item_refresher_custom"] = true,
    ["item_refresher_shard"] = true,
    ["item_ex_machina"] = true,
    ["item_ex_machina_custom"] = true,
    ["nolik_tech"] = true,
    ["kakashi_sharingan"] = true,
    ["Overlord_spell_14"] = true,
    ["travoman_minefield_sign"] = true,
    ["Vjlink_dudos"] = true,
}

function item_refresher_shard_custom:NotRefresher( item )
    return self.NotRefresh[item:GetName()]
end

function item_refresher_shard_custom:OnSpellStart()
    for i=0, self:GetCaster():GetAbilityCount()-1 do
        local ability = self:GetCaster():GetAbilityByIndex( i )
        if ability and ability:GetAbilityType()~=DOTA_ABILITY_TYPE_ATTRIBUTES and not self:NotRefresher( ability ) then
            ability:RefreshCharges()
            ability:EndCooldown()
        end
    end

    for i=0,5 do
        local item = self:GetCaster():GetItemInSlot(i)
        if item then
            if not self:NotRefresher( item ) then
                item:EndCooldown()
            end
        end
    end

    local item_neutral = self:GetCaster():GetItemInSlot(16)
    if item_neutral then
        if not self:NotRefresher( item_neutral ) then
            item_neutral:EndCooldown()
        end
    end

    self:GetCaster():EmitSound("DOTA_Item.Refresher.Activate")

    local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
    self:SpendCharge()
end