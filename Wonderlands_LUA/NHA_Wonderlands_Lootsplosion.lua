
Wonderlands.LootsplosionRequiresReset=false;

function _EnableLootExplosion(EnemyAddress)
local Address=NHA_CE.HEX.ConvertFromInt64(GetAIBalanceState(EnemyAddress));

local weapons =   readFloat('[[[[['..Address..'+280]+0]+50]+220]+48]+228')
local shields =   readFloat('[[[[['..Address..'+280]+0]+50]+330]+48]+228')
local spells =readFloat('[[[[['..Address..'+280]+0]+50]+3B8]+48]+228')
local melee = readFloat('[[[[['..Address..'+280]+0]+50]+440]+48]+228')
local rings = readFloat('[[[[['..Address..'+280]+0]+50]+4C8]+48]+228')
local amulets =   readFloat('[[[[['..Address..'+280]+0]+50]+550]+48]+228')
local pauldrons = readFloat('[[[[['..Address..'+280]+0]+50]+5D8]+48]+228')

if weapons == 1 and
shields == 1 and
 spells == 1 and
  melee == 1 and
 rings == 1 and
   amulets == 1 and
  pauldrons == 1 then
--TEST
 print("Entity: "..Address.." Enabling Loot Splosion");

writeFloat('[[['..Address..'+280]+0]+50]+258',9999999)  --Weapons Probability  --Good
writeFloat('[[['..Address..'+280]+0]+50]+368',9999999)  --Shields Probability  --Good
writeFloat('[[['..Address..'+280]+0]+50]+3F0',9999999)  --Spells Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+478',9999999)  --Melee Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+500',9999999)  --Rings Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+588',9999999)  --Amulets Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+610',9999999)  --Pauldron Probability   --Good

writeFloat('[[['..Address..'+280]+0]+50]+290',Wonderlands.LootSplosionAmounts.Weapons)--Weapons Times to pull -- Good
writeFloat('[[['..Address..'+280]+0]+50]+3A0',Wonderlands.LootSplosionAmounts.Shields)--Shields Times to pull --Good
writeFloat('[[['..Address..'+280]+0]+50]+428',Wonderlands.LootSplosionAmounts.Spells)--Spells Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+4B0',Wonderlands.LootSplosionAmounts.Melee)--Melee Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+538',Wonderlands.LootSplosionAmounts.Rings)--Rings Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+5C0',Wonderlands.LootSplosionAmounts.Amulets)--Amulets Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+648',Wonderlands.LootSplosionAmounts.Pauldron)--Pauldron Times to pull  --Good

writeFloat('[[[[['..Address..'+280]+0]+50]+220]+48]+228',9999999)   --Legendary Weapons --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+330]+48]+228',9999999)   --Legendary Shield  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+3B8]+48]+228',9999999)   --Legendary Spells  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+440]+48]+228',9999999)   --Legendary Melee  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+4C8]+48]+228',9999999)   --Legendary Rings  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+550]+48]+228',9999999)   --Legendary Amulets  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+5D8]+48]+228',9999999)   --Legendary Pauldron  --Good
end
end

function _DisableLootExplosion(EnemyAddress)
if Wonderlands.LootsplosionRequiresReset==true then
local Address=NHA_CE.HEX.ConvertFromInt64(GetAIBalanceState(EnemyAddress));

local weapons =   readFloat('[[[[['..Address..'+280]+0]+50]+220]+48]+228')
local shields =   readFloat('[[[[['..Address..'+280]+0]+50]+330]+48]+228')
local spells =readFloat('[[[[['..Address..'+280]+0]+50]+3B8]+48]+228')
local melee = readFloat('[[[[['..Address..'+280]+0]+50]+440]+48]+228')
local rings = readFloat('[[[[['..Address..'+280]+0]+50]+4C8]+48]+228')
local amulets =   readFloat('[[[[['..Address..'+280]+0]+50]+550]+48]+228')
local pauldrons = readFloat('[[[[['..Address..'+280]+0]+50]+5D8]+48]+228')


writeFloat('[[['..Address..'+280]+0]+50]+258',1)  --Weapons Probability  --Good
writeFloat('[[['..Address..'+280]+0]+50]+368',1)  --Shields Probability  --Good
writeFloat('[[['..Address..'+280]+0]+50]+3F0',1)  --Spells Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+478',1)  --Melee Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+500',1)  --Rings Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+588',1)  --Amulets Probability   --Good
writeFloat('[[['..Address..'+280]+0]+50]+610',1)  --Pauldron Probability   --Good

writeFloat('[[['..Address..'+280]+0]+50]+290',1)--Weapons Times to pull -- Good
writeFloat('[[['..Address..'+280]+0]+50]+3A0',1)--Shields Times to pull --Good
writeFloat('[[['..Address..'+280]+0]+50]+428',1)--Spells Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+4B0',1)--Melee Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+538',1)--Rings Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+5C0',1)--Amulets Times to pull  --Good
writeFloat('[[['..Address..'+280]+0]+50]+648',1)--Pauldron Times to pull  --Good

writeFloat('[[[[['..Address..'+280]+0]+50]+220]+48]+228',1)   --Legendary Weapons --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+330]+48]+228',1)   --Legendary Shield  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+3B8]+48]+228',1)   --Legendary Spells  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+440]+48]+228',1)   --Legendary Melee  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+4C8]+48]+228',1)   --Legendary Rings  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+550]+48]+228',1)   --Legendary Amulets  --Good
writeFloat('[[[[['..Address..'+280]+0]+50]+5D8]+48]+228',1)   --Legendary Pauldron  --Good
end
end


Wonderlands.LootSplosionAmounts={};
Wonderlands.LootSplosionAmounts.Weapons=2;
Wonderlands.LootSplosionAmounts.Shields=2;
Wonderlands.LootSplosionAmounts.Spells=2;
Wonderlands.LootSplosionAmounts.Melee=2;
Wonderlands.LootSplosionAmounts.Rings=2;
Wonderlands.LootSplosionAmounts.Amulets=2;
Wonderlands.LootSplosionAmounts.Pauldron=2;

Wonderlands.LootSplosion=false;

function Wonderlands.SetLootExplosionState(state)
Wonderlands.LootSplosion=state;
end


function Wonderlands._LootSploasionFunc()
if Wonderlands.IsInGame() then
if Wonderlands.LootSplosion and Wonderlands.LootsplosionRequiresReset==false then
Foreach_IsAI_PlayerTargetable(_EnableLootExplosion);
elseif Wonderlands.LootsplosionRequiresReset==true then
Foreach_IsAI_PlayerTargetable(_DisableLootExplosion);
Wonderlands.LootsplosionRequiresReset=false;
else
Foreach_IsAI_PlayerTargetable(_DisableLootExplosion);
end
end
end



--[[
Lootsplosion UI
]]
function Wonderlands.OpenLootsplosionUI()
if LootsplosionUI.isForegroundWindow()==false then
Wonderlands.LootsplosionUI_Refresh();

LootsplosionUI.centerScreen();
 FixSyncIssue(function()
LootsplosionUI.showModal();
 end,10);
 end
end

function Wonderlands.LootsplosionUI_Refresh()
LootsplosionUI.WeaponsValue.setCaption(Wonderlands.LootSplosionAmounts.Weapons);
LootsplosionUI.ShieldsValue.setCaption(Wonderlands.LootSplosionAmounts.Shields);
LootsplosionUI.SpellsValue.setCaption(Wonderlands.LootSplosionAmounts.Spells);
LootsplosionUI.MeleeValue.setCaption(Wonderlands.LootSplosionAmounts.Melee);
LootsplosionUI.RingsValue.setCaption(Wonderlands.LootSplosionAmounts.Rings);
LootsplosionUI.AmuletsValue.setCaption(Wonderlands.LootSplosionAmounts.Amulets);
LootsplosionUI.PauldronValue.setCaption(Wonderlands.LootSplosionAmounts.Pauldron);

local PFA="Disabled";
if Wonderlands.LootSplosion then
PFA="Enabled";
end
LootsplosionUI.setCaption("Lootsplosion V3 : "..PFA);
end

function LootsplosionUI_EnableButtonClick(sender)
Wonderlands.SetLootExplosionState(true);
Wonderlands.LootsplosionUI_Refresh();
Wonderlands.LootsplosionRequiresReset=true;
end

function LootsplosionUI_DisableButtonClick(sender)
Wonderlands.SetLootExplosionState(false);
Wonderlands.LootsplosionUI_Refresh();
Wonderlands.LootsplosionRequiresReset=true;
end

function ExtractValue(ValBox)
local CAP=ValBox.getCaption();
if CAP==nil then
return 0;
else
return tonumber(CAP);
end
end

function AlightProperLsplosionVal(sender)
local CAP=ExtractValue(sender);
if CAP==1 then
sender.setCaption(0);
end
end

function LootsplosionUI_WeaponsValueKeyUp(sender, key)
AlightProperLsplosionVal(sender)
Wonderlands.LootSplosionAmounts.Weapons=ExtractValue(sender);
Wonderlands.LootsplosionRequiresReset=true;
  return key
end

function LootsplosionUI_ShieldsValueKeyUp(sender, key)
AlightProperLsplosionVal(sender)
Wonderlands.LootSplosionAmounts.Shields=ExtractValue(sender);
Wonderlands.LootsplosionRequiresReset=true;
  return key
end

function LootsplosionUI_SpellsValueKeyUp(sender, key)
AlightProperLsplosionVal(sender)
Wonderlands.LootSplosionAmounts.Spells=ExtractValue(sender);
Wonderlands.LootsplosionRequiresReset=true;
  return key
end

function LootsplosionUI_MeleeValueKeyUp(sender, key)
AlightProperLsplosionVal(sender)
Wonderlands.LootSplosionAmounts.Melee=ExtractValue(sender);
Wonderlands.LootsplosionRequiresReset=true;
  return key
end

function LootsplosionUI_RingsValueKeyUp(sender, key)
AlightProperLsplosionVal(sender)
Wonderlands.LootSplosionAmounts.Rings=ExtractValue(sender);
Wonderlands.LootsplosionRequiresReset=true;
  return key
end

function LootsplosionUI_AmuletsValueKeyUp(sender, key)
AlightProperLsplosionVal(sender)
Wonderlands.LootSplosionAmounts.Amulets=ExtractValue(sender);
Wonderlands.LootsplosionRequiresReset=true;
  return key
end

function LootsplosionUI_PauldronValueKeyUp(sender, key)
AlightProperLsplosionVal(sender)
Wonderlands.LootSplosionAmounts.Pauldron=ExtractValue(sender);
Wonderlands.LootsplosionRequiresReset=true;
  return key
end
