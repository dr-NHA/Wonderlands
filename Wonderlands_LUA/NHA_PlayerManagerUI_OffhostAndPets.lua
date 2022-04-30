
--[[


    Offhost Menu


]]

function PlayerUI_SelfSuperMeleeClick(sender)

end






function PlayerUI_MushroomPetSpawnClick(sender)
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
DuplicatePet(PlayerClass,0)
end);
end

function PlayerUI_DemiLichPetSpawnClick(sender)
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
DuplicatePet(PlayerClass,1)
end);
end

function PlayerUI_WyvernPetSpawnClick(sender)
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
DuplicatePet(PlayerClass,2)
end);
end

function PlayerUI_PetsSetClassesClick(sender)
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
SetPetClass(PlayerClass,0,GetAddress(PlayerUI.MushroomPetClass.Text));
SetPetClass(PlayerClass,1,GetAddress(PlayerUI.DemiLichPetClass.Text));
SetPetClass(PlayerClass,2,GetAddress(PlayerUI.WyvernPetClass.Text));

end);
PlayerUI_ReloadPetClasses();
end

function PlayerUI_ReloadPetClasses()
PlayerUI.MushroomPetClass.Text=NHA_CE.HEX.ConvertFromInt64(PlayerUI_GetDefaultValue(function(PlayerBase);return
GetPetClass(PlayerBase,0);end,0x00000000));

PlayerUI.DemiLichPetClass.Text=NHA_CE.HEX.ConvertFromInt64(PlayerUI_GetDefaultValue(function(PlayerBase);return
GetPetClass(PlayerBase,1);end,0x00000000));

PlayerUI.WyvernPetClass.Text=NHA_CE.HEX.ConvertFromInt64(PlayerUI_GetDefaultValue(function(PlayerBase);return
GetPetClass(PlayerBase,2);end,0x00000000));

end


function PlayerUI_RefreshPetValuesClick(sender)

PlayerUI_ReloadPetClasses();
end






