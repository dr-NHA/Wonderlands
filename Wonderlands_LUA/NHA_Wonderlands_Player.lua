
--[[
    Mother Variable For Player Restricted Functions!
]]
 Players={};

registerSymbol("Character.PetOwnerComponent","2DC0");
registerSymbol("PetOwnerComponent.PetInfo","1B8");
registerSymbol("PetInfo.ComponentSize",0x158);


--[[

Player Function Helpers

]]

--Function To Easily Get The String Path To The Player Array
Players.Array={
Address=function()
return getAddress("[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]");
end,
Count={
Address=function()
return GetAddress("RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray_size");
end,
Get=function()
return readInteger(Players.Array.Count.Address());
end,
},
};


Players.ErrorCheck=function()
return Wonderlands.PointerChecksOut("[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]+0]+Player.PlayerCharacter");
end

local RO=function(index)
local _NHA={
Index=index,
};
_NHA.PlayerPath="[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]".."+"..List_IndexToHex(index).."]";
_NHA.PlayerCharacterPointerPath="[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]".."+"..List_IndexToHex(index).."]+Player.PlayerCharacter";
_NHA.PlayerCharacterPath="[[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]".."+"..List_IndexToHex(index).."]+Player.PlayerCharacter]";
_NHA.OwnerPath="[[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]".."+"..List_IndexToHex(index).."]+Object.Owner]";
--Address Functions
_NHA.CE_CHECK=function(NDX)
if Players.Array.Count.Get()>index then
return GetAddress(NDX);else;return 0xDEADBEEF;end;
end

_NHA.Address=function();return _NHA.CE_CHECK(_NHA.PlayerPath);end
_NHA.CharacterPointerAddress=function();return _NHA.CE_CHECK(_NHA.PlayerCharacterPointerPath);end
_NHA.CharacterAddress=function();return _NHA.CE_CHECK(_NHA.PlayerCharacterPath);end
_NHA.OwnerAddress=function();return _NHA.CE_CHECK(_NHA.OwnerPath);end

--Get The Players TeamName
_NHA.TeamName=function();return Entity.GetTeamName(_NHA.PlayerCharacterPath);end

--Get The Player Name
_NHA.Name=function();return ReadString("[".._NHA.PlayerPath.."+460]+0",50,true);end

--[[Godmode Function]]
_NHA.Godmode=FGetSetBool(function(P);return '['.._NHA.PlayerCharacterPath..'+EC0]+840';end,0,1);
_NHA.EnableGodMode=function();_NHA.Godmode.Set(true);end;
_NHA.DisableGodMode=function();_NHA.Godmode.Set(false);end;

--Is Noclip Enabled Check
_NHA.Noclip=FGetSetBool(function(P);return _NHA.PlayerCharacterPath..'+93';end,0x9D,0x1D);

--Is Noclip Enabled Check
_NHA.FlyEnabled=FGetSetBool(function(P);return "[".._NHA.PlayerCharacterPath..'+4C8]+248';end,0x3,0x5);

_NHA.NoclipAndFly={
Get=function();return _NHA.Noclip.Get()==true and _NHA.FlyEnabled.Get()==true;end,
Set=function(boolvalue)
_NHA.Noclip.Set(boolvalue);
_NHA.FlyEnabled.Set(boolvalue);
end,
};

--Is Visible Check
_NHA.IsVisible=FGetSetBool(function(P);return '[['.._NHA.PlayerCharacterPath..'+490]+950]+26C';end,0,1);
_NHA.Hide=function();_NHA.IsVisible.Set(false);end
_NHA.Show=function();_NHA.IsVisible.Set(true);end

--Is Targetable Check
_NHA.IsTargetable=FGetSetBool(function(P);return '[['.._NHA.PlayerCharacterPath..'+490]+950]+3B8';end,1,0);

--Float Scale Of Damge To Effect
_NHA.DamageModifier=FGetSetFloat(function(P);return '['.._NHA.PlayerCharacterPath..'+EC8]+2C8';end);
_NHA.MaxDamageModifier=function();_NHA.DamageModifier.Set(133333337);end
_NHA.ResetDamageModifier=function();_NHA.DamageModifier.Set(1.090000033);end

--Float Scale Of Damge To Effect
_NHA.CriticalChance=FGetSetFloat(function(P);return '['.._NHA.PlayerCharacterPath..'+EC8]+31C';end);
_NHA.MaxCriticalChance=function();_NHA.CriticalChance.Set(133333337);end
_NHA.ResetCriticalChance=function();_NHA.CriticalChance.Set(0.05000000075);end

_NHA.AmmoRegen=FGetSetFloat(function();return _NHA.PlayerCharacterPath..'+PlayerController.AmmoRegenRate';end);
_NHA.MaxAmmoRegen=function();_NHA.AmmoRegen.Set(999999999);end;
_NHA.ResetAmmoRegen=function();_NHA.AmmoRegen.Set(0);end;


_NHA.Health=ResourcePool.FNewPoolView(function();return _NHA.PlayerCharacterPath;end,1);
_NHA.Shield=ResourcePool.FNewPoolView(function();return _NHA.PlayerCharacterPath;end,2);


_NHA.Position=FGetSetVector3(function();return '['.._NHA.PlayerCharacterPath..Entity.PositionOffset(_NHA.PlayerCharacterPath)..']+220';end);

_NHA.TeleportToPlayer=function(PlayerDest)
_NHA.Position.X.Set(PlayerDest.Position.X.Get());
_NHA.Position.Y.Set(PlayerDest.Position.Y.Get());
_NHA.Position.Z.Set(PlayerDest.Position.Z.Get());
end


_NHA.Movement={
Gravity=FGetSetFloat(function();return "[".._NHA.PlayerCharacterPath..'+900]+230';end);
MaxWalkSpeed=FGetSetFloat(function();return "[".._NHA.PlayerCharacterPath..'+4C8]+278';end);
MaxCrouchSpeed=FGetSetFloat(function();return "[".._NHA.PlayerCharacterPath..'+4C8]+284';end);
MaxSprintSpeed=FGetSetFloat(function();return "[".._NHA.PlayerCharacterPath..'+4C8]+2980';end);
MaxJumpCount=FGetSetInteger(function();return _NHA.PlayerCharacterPath..'+580';end);
ToString=function();return 
"Gravity: "..NilReadProtect(_NHA.Movement.Gravity.Get()).."\n"..
"MaxWalkSpeed: "..NilReadProtect(_NHA.Movement.MaxWalkSpeed.Get()).."\n"..
"MaxCrouchSpeed: "..NilReadProtect(_NHA.Movement.MaxCrouchSpeed.Get()).."\n"..
"MaxSprintSpeed: "..NilReadProtect(_NHA.Movement.MaxSprintSpeed.Get()).."\n"..
"MaxJumpCount: "..NilReadProtect(_NHA.Movement.MaxJumpCount.Get())
;end;
};


_NHA.Movement.SuperJump={
Set=function(value)
if value==true then
_NHA.Movement.MaxJumpCount.Set(9999999);
_NHA.Movement.Gravity.Set(0.5);
else
_NHA.Movement.MaxJumpCount.Set(1);
_NHA.Movement.Gravity.Set(1);
end;end,
Get=function();return _NHA.Movement.Gravity.Get()==0.5 and _NHA.Movement.MaxJumpCount.Get()==9999999;end
}


_NHA.Movement.SuperSpeed={
Multiplier=4,
Set=function(value)
if value then
_NHA.Movement.MaxWalkSpeed.Set(470*_NHA.Movement.SuperSpeed.Multiplier);
_NHA.Movement.MaxCrouchSpeed.Set(275*_NHA.Movement.SuperSpeed.Multiplier);
_NHA.Movement.MaxSprintSpeed.Set(720*_NHA.Movement.SuperSpeed.Multiplier);
else
_NHA.Movement.MaxWalkSpeed.Set(470);
_NHA.Movement.MaxCrouchSpeed.Set(275);
_NHA.Movement.MaxSprintSpeed.Set(720);
end;end,
Get=function();return 
_NHA.Movement.MaxWalkSpeed.Get()==470*_NHA.Movement.SuperSpeed.Multiplier and
 _NHA.Movement.MaxCrouchSpeed.Get()==275*_NHA.Movement.SuperSpeed.Multiplier and
 _NHA.Movement.MaxSprintSpeed.Get()==720*_NHA.Movement.SuperSpeed.Multiplier end
}



_NHA.Currency={
MaxInteger=2133333337,
AltMaxInteger=133333337,
Path=function();return '[['.._NHA.PlayerCharacterPath..'+EE0]+228]';end,
PremiumPath=function();return '[['.._NHA.PlayerCharacterPath..'+118]+2528]';end,
Size=function();return readInteger("[".._NHA.PlayerCharacterPath.."+EE0]+230");end,
InventoryDataIndexId=function(index)return NHA_CE.HEX.GetAddress(0x78*index);end,
};
_NHA.Currency.InventoryDataAddress=function(index);return _NHA.Currency.Path().."+".._NHA.Currency.InventoryDataIndexId(index);end
_NHA.Currency.GetInventoryDataQuanityAddress=function(index);return GetAddress(_NHA.Currency.InventoryDataAddress(index).."+18");end
_NHA.Currency.GetInventoryDataQuanity=function(index);return readInteger(_NHA.Currency.GetInventoryDataQuanityAddress(index));end
_NHA.Currency.SetInventoryDataQuanity=function(index,value);WriteInteger(_NHA.Currency.GetInventoryDataQuanityAddress(index),value);end
_NHA.Currency.GetInventoryDataReplicationId=function(index);return readInteger(_NHA.Currency.InventoryDataAddress(index));end
_NHA.Currency.GetInventoryDataReplicationKey=function(index);return readInteger(_NHA.Currency.InventoryDataAddress(index).."+4");end
_NHA.Currency.GetInventoryDataHandle=function(index);return readInteger(_NHA.Currency.InventoryDataAddress(index).."+C");end

_NHA.Currency.RainbowGemOffset=function()
local n=nil;local CAP=_NHA.Currency.Size();
if CAP~=nil then;for index=0,CAP,1 do
local X=_NHA.Currency.GetInventoryDataReplicationId(index) ;
local Handle=_NHA.Currency.GetInventoryDataHandle(index);
local ReplicationKey=_NHA.Currency.GetInventoryDataReplicationKey(index);
local Count=_NHA.Currency.GetInventoryDataQuanity(index);
if  X>=4 and X<=50 and  Count<1000000000 and Handle>80 and Handle<2920 and ReplicationKey~=4294967295 and ReplicationKey>=1 then;n=index;break;end;end
if n==nil then;return 0xDEADBEEF;else;return _NHA.Currency.InventoryDataIndexId(n);end
end;
return 0xDEADBEEF;
end

--Added Detection Incase A User Has Launched With Offline Enabled
_NHA.Currency.SkeletonKeys=FGetSetInteger(function();
local PP=getAddress(_NHA.Currency.PremiumPath());
if PP~=nil then
if PP~=0 then
return  _NHA.Currency.PremiumPath()..'+8';
end;end
return 0xDEADBEEF
end);

_NHA.Currency.Money=FGetSetInteger(function();return  _NHA.Currency.GetInventoryDataQuanityAddress(0);end);
_NHA.Currency.Crystals=FGetSetInteger(function();return _NHA.Currency.GetInventoryDataQuanityAddress(1);end);
_NHA.Currency.Souls=FGetSetInteger(function();
if _NHA.Currency.GetInventoryDataReplicationId(2)==3 then
return _NHA.Currency.GetInventoryDataQuanityAddress(2);
elseif _NHA.Currency.GetInventoryDataReplicationId(3)==3 then
return _NHA.Currency.GetInventoryDataQuanityAddress(3);
elseif _NHA.Currency.GetInventoryDataReplicationId(4)==3 then
return _NHA.Currency.GetInventoryDataQuanityAddress(4);
end
return 0xDEADBEEF;
end);
_NHA.Currency.RainbowGems=FGetSetInteger(function();
local PP=_NHA.Currency.RainbowGemOffset();
if PP~=0xDEADBEEF then
if PP~=0 then
return  _NHA.Currency.Path()..'+'.._NHA.Currency.RainbowGemOffset().."+18";
end;end
return 0xDEADBEEF
;end);

_NHA.Currency.MaxAll=function()
_NHA.Currency.Money.Set(_NHA.Currency.MaxInteger);
_NHA.Currency.Crystals.Set(_NHA.Currency.MaxInteger);
_NHA.Currency.Souls.Set(_NHA.Currency.MaxInteger);
if _NHA.Currency.RainbowGems.HexAddress()~="DEADBEEF" then;_NHA.Currency.RainbowGems.Set(_NHA.Currency.AltMaxInteger);end
if _NHA.Currency.SkeletonKeys.HexAddress()~="DEADBEEF" then;_NHA.Currency.SkeletonKeys.Set(_NHA.Currency.AltMaxInteger);end
end

_NHA.Currency.ToString=function();
return 
"Money: "..NilReadProtect(_NHA.Currency.Money.Get()).."\n"..
"Crystals: "..NilReadProtect(_NHA.Currency.Crystals.Get()).."\n"..
"Souls: "..NilReadProtect(_NHA.Currency.Souls.Get()).."\n"..
"RainbowGems: "..BoolToObject(_NHA.Currency.RainbowGemOffset()==0x0,NilReadProtect(_NHA.Currency.RainbowGems.Get()),"Not In Chaos Chamber")
;end;

_NHA.Currency.IndexToName=function(Index)
if Index==0 then
return "Money";
elseif Index==1 then
return "Crystals";
else

end
return "Unknown";
end

_NHA.Currency.PrintAll=function()
local CAP=_NHA.Currency.Size();
if CAP~=nil then
for index=0,CAP,1 do
print('['..index..'] '..
NHA_CE.HEX.GetAddress(_NHA.Currency.InventoryDataAddress(index))..
', ReplicationId: '.._NHA.Currency.GetInventoryDataReplicationId(index) ..
", Quantity: ".._NHA.Currency.GetInventoryDataQuanity(index)..
", Handle: ".._NHA.Currency.GetInventoryDataHandle(index)..
", ReplicationKey: ".._NHA.Currency.GetInventoryDataReplicationKey(index));
end
end
end


_NHA.Pets={
CalculatePetAddress=function(Index);return getAddress("PetInfo.ComponentSize")*Index;end,
GetPetInfoBase=function(Index)
return getAddress("[[".._NHA.PlayerCharacterPath.."+Character.PetOwnerComponent]+PetOwnerComponent.PetInfo]+"..NHA_CE.HEX.ConvertFromInt64( _NHA.Pets.CalculatePetAddress(Index) ));
end,

};

--[[
	Get And Set If The Pet Is Active
]]
_NHA.Pets.PetActive={
Get=function(Index);return ReadByte(_NHA.Pets.GetPetInfoBase(Index) )~=0;end,
Set=function(Index,value);WriteByte(_NHA.Pets.GetPetInfoBase(Index) ,BoolToObject(value,0,1));end,
}

_NHA.Pets.PetLastActive={
Get=function(Index);return ReadByte(_NHA.Pets.GetPetInfoBase(Index)+0x1 )~=0;end,
Set=function(Index,value);WriteByte(_NHA.Pets.GetPetInfoBase(Index)+0x1 ,BoolToObject(value,0,1));end,
}

_NHA.Pets.PetClass={
Get=function(Index);return ReadPointer(_NHA.Pets.GetPetInfoBase(Index)+0x8 );end,
Set=function(Index,value);WritePointer(_NHA.Pets.GetPetInfoBase(Index)+0x8,value);end,
}

_NHA.Pets.CurrentPetPointer={
Get=function(Index);return ReadPointer(_NHA.Pets.GetPetInfoBase(Index)+0xE8 );end,
Set=function(Index,value);WritePointer(_NHA.Pets.GetPetInfoBase(Index)+0xE8,value);end,
}

_NHA.Pets.SpawnCount={
Get=function(Index);return ReadInteger(_NHA.Pets.GetPetInfoBase(Index)+0xF0 );end,
Set=function(Index,value);WriteInteger(_NHA.Pets.GetPetInfoBase(Index)+0xF0,value);end,
}

_NHA.Pets.LocalSpawnCount={
Get=function(Index);return ReadInteger(_NHA.Pets.GetPetInfoBase(Index)+0xF4 );end,
Set=function(Index,value);WriteInteger(_NHA.Pets.GetPetInfoBase(Index)+0xF4,value);end,
}

_NHA.Pets.DoNotAllowPetSpawning={
Get=function(Index);return ReadByte(_NHA.Pets.GetPetInfoBase(Index)+0x110 )~=0;end,
Set=function(Index,value);WriteByte(_NHA.Pets.GetPetInfoBase(Index)+0x110 ,BoolToObject(value,0,1));end,
}


_NHA.Pets.PrintPetInfomation=function(Index)
if _NHA.CharacterAddress()~="DEADBEEF" then
print("["..NHA_CE.HEX.ConvertFromInt64(_NHA.Pets.GetPetInfoBase(Index)).."] Pet: "..Index);
print("IsActive: "..BoolToObject(_NHA.Pets.PetActive.Get(Index),"Active","Inactive"));
print("WasLastActive: "..BoolToObject(_NHA.Pets.PetLastActive.Get(Index),"True","False"));
print("Class: "..NHA_CE.HEX.ConvertFromInt64(_NHA.Pets.PetClass.Get(Index)));
print("Current Pet: "..NHA_CE.HEX.ConvertFromInt64(_NHA.Pets.CurrentPetPointer.Get(Index)));
print("Spawn Count: ".._NHA.Pets.SpawnCount.Get(PlayerCharacter,Index));
print("Local Spawn Count: ".._NHA.Pets.LocalSpawnCount.Get(Index));
print("Spawn Blocked: "..BoolToObject(_NHA.Pets.DoNotAllowPetSpawning.Get(Index),"Yes","No"));

else
print("Player Isnt Spawned!");
end
end

_NHA.Pets.DuplicatePet=function(petindex)
_NHA.Pets.PetActive.Set(petindex,true);
_NHA.Pets.DoNotAllowPetSpawning.Set(petindex,false);
_NHA.Pets.CurrentPetPointer.Set(petindex,0);
createThread(function()
sleep(60);
_NHA.Pets.DoNotAllowPetSpawning.Set(petindex,false);
_NHA.Pets.CurrentPetPointer.Set(petindex,0);
sleep(700);
_NHA.Pets.DoNotAllowPetSpawning.Set(petindex,true);
end)
end







_NHA.SkillTree={

GetOffsetByIndex=function(Index);return 0x30*Index;end,

Path="[[".._NHA.PlayerCharacterPath.."+PlayerController.PlayerAbilityManagerComponent]+PlayerAbilityManagerComponent.PlayerAbilityTree]+PlayerAbilityTree.Items";

Size=function();return readInteger(_NHA.SkillTree.Path.."+8");end,

SkillTreeBase=function();return readPointer(_NHA.SkillTree.Path);end,

GetItemBase=function(Index)
return _NHA.SkillTree.SkillTreeBase()+_NHA.SkillTree.GetOffsetByIndex(Index);
end,

};

_NHA.SkillTree.ItemLevel={
Address=function(Index);return _NHA.SkillTree.GetItemBase(Index)+0x28;end,
Get=function(Index);return readInteger(_NHA.SkillTree.ItemLevel.Address(Index));end,
Set=function(Index,Value);WriteInteger(_NHA.SkillTree.ItemLevel.Address(Index),Value);end,
}


_NHA.SkillTree.ItemId={
Address=function(Index);return _NHA.SkillTree.GetItemBase(Index)+0x10;end,
Get=function(Index);return readInteger(_NHA.SkillTree.ItemId.Address(Index));end,
Set=function(Index,Value);WriteInteger(_NHA.SkillTree.ItemId.Address(Index),Value);end,
}

_NHA.SkillTree.ItemData={
Address=function(Index);return _NHA.SkillTree.GetItemBase(Index)+0x8;end,
Get=function(Index);return readPointer(_NHA.SkillTree.ItemData.Address(Index));end,
Set=function(Index,Value);WritePointer(_NHA.SkillTree.ItemData.Address(Index),Value);end,
}

_NHA.SkillTree.ItemMaxLevel={
Address=function(Index);return _NHA.SkillTree.ItemData.Get(Index)+0x30;end,
Get=function(Index);return readInteger(_NHA.SkillTree.ItemMaxLevel.Address(Index));end,
Set=function(Index,Value);WriteInteger(_NHA.SkillTree.ItemMaxLevel.Address(Index),Value);end,
}

_NHA.SkillTree.Foreach=function(DO)
local Index=0;
for Index=0,_NHA.SkillTree.Size()-1,1 do
DO(Index);
end;
end

_NHA.SkillTree.PrintAll=function()
_NHA.SkillTree.Foreach(function(Index);print("Item: "..Index..
", ItemBase: "..NHA_CE.HEX.ConvertFromInt64(_NHA.SkillTree.GetItemBase(Index))..
", ItemId: ".._NHA.SkillTree.ItemId.Get(Index)..
", ItemLevel: ".._NHA.SkillTree.ItemLevel.Get(Index)..
", ItemMaxLevel: ".._NHA.SkillTree.ItemMaxLevel.Get(Index)..
", ItemData: "..NHA_CE.HEX.ConvertFromInt64(_NHA.SkillTree.ItemData.Get(Index))
);end);
end


_NHA.SkillTree.SetAllLevels=function(Level)
_NHA.SkillTree.Foreach(function(Index)
_NHA.SkillTree.ItemLevel.Set(Index,Level);
end);
end

_NHA.SkillTree.MaxAllLevelsMultiplied=function(Level)
if Level<0 then;Level=0;end;
_NHA.SkillTree.Foreach(function(Index)
_NHA.SkillTree.ItemLevel.Set(Index,_NHA.SkillTree.ItemMaxLevel.Get(Index)*Level);
end);
end

_NHA.SkillTree.MaxAllLevels=function()
_NHA.SkillTree.Foreach(function(Index)
_NHA.SkillTree.ItemLevel.Set(Index,_NHA.SkillTree.ItemMaxLevel.Get(Index));
end);
end


_NHA.PrintAllInfo=function()
print("*DEBUG:* Player Info");
print("Index: "..index);
print("Address: "..NHA_CE.HEX.ConvertFromInt64(_NHA.Address()));
print("Name: ".._NHA.Name());
print("Team: ".._NHA.TeamName());
print("IsVisible: "..BoolToObject( _NHA.IsVisible.Get(),"False","True"));
print("IsTargetable: "..BoolToObject( _NHA.IsTargetable.Get(),"False","True"));
print("Godmode: "..BoolToObject( _NHA.Godmode.Get(),"Disabled","Enabled"));
print("Noclip: "..BoolToObject( _NHA.Noclip.Get(),"Disabled","Enabled"));
print("FlyEnabled: "..BoolToObject( _NHA.FlyEnabled.Get(),"Disabled","Enabled"));
print("DamageModifier: "..NilReadProtect(_NHA.DamageModifier.Get()));
print("CriticalChance: "..NilReadProtect(_NHA.CriticalChance.Get()));
print("AmmoRegen: "..NilReadProtect(_NHA.AmmoRegen.Get()));
print("Position: ".._NHA.Position.ToString());
print("Movement:\n".._NHA.Movement.ToString());
print("Currency:\n".._NHA.Currency.ToString());

end


return _NHA;
end

function NilReadProtect(Read)
local NHAX=Read;if NHAX==nil then;NHAX="Value Cannot Be Read!";end;
return NHAX;
end

Players.Host=RO(0);
Players.Player2=RO(1);
Players.Player3=RO(2);
Players.Player4=RO(3);


--[[ Get A Player Address By The Index Of The Player]]
Players.GetPlayer=function(Index)
if Index==0 then
return Players.Host;
elseif Index==1 then
return Players.Player2;
elseif Index==2 then
return Players.Player3;
elseif Index==3 then
return Players.Player4;
else
return nil
end
end;

ForeachPlayer=function(action)
if Players.ErrorCheck() then
local C=Players.Array.Count.Get();
if C~=nil then
ForeachBuilder(Players.GetPlayer,C-1,function(playerclass)
if playerclass~=0 then
action(playerclass);
end
end);
end;
end
end;





