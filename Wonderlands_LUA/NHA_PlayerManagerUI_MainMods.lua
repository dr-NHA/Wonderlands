
function PlayerUI_FormClose(sender)

return caHide --Possible options: caHide, caFree, caMinimize, caNone
end


function OpenPlayerUI(memrec)
FixSyncIssue(function()
PlayerUI.Hide();
PlayerUI.WindowState = 'wsNormal'
PlayerUI.centerScreen();
PlayerUI.bringToFront();
PlayerUI.Show();
if memrec~=nil then
if memrec.Active then
memrec.Active=false;
end
end
end,70);
end



Wonderlands.UI_Tick=function()
UpdateUIPlayerList()
if (NHA_CE.HOOK~="") then
Wonderlands.AutoModTick()
end
end

function Wonderlands.AutoModTick()
if Players.ErrorCheck() then
PlayerIndex=0;
ForeachPlayer(function(Player)
Wonderlands.PlayerAutoModFunction(PlayerIndex,Player);
PlayerIndex=PlayerIndex+1;
end);
end
end


function Wonderlands.PlayerAutoModFunction(PlayerIndex,Player)
OnGodmodeNeeded(PlayerIndex,Player);
OnDamageNeeded(PlayerIndex,Player);
OnInfinateAmmoNeeded(PlayerIndex,Player);
OnSuperJumpNeeded(PlayerIndex,Player);
OnSuperSpeedNeeded(PlayerIndex,Player);
OnMaxMoneyNeeded(PlayerIndex,Player);
OnNoclipNeeded(PlayerIndex,Player);
OnNoTargetNeeded(PlayerIndex,Player);
end




function Wonderlands.PresetPlayerAutoMod()
return {
GodMode=false,
InfinateAmmo=false,
SuperJump=false,
SuperSpeed=false,
MaxMoney=false,
Noclip=false,
Damage=false,
Invisible=false,
NoTarget=false,
};
end
Wonderlands.PlayerAutoMod={
Wonderlands.PresetPlayerAutoMod(),--Player 0
Wonderlands.PresetPlayerAutoMod(),--Player 1
Wonderlands.PresetPlayerAutoMod(),--Player 2
Wonderlands.PresetPlayerAutoMod(),--Player 3
};




function UpdatePlayerListIndex(index)
local CAP=Players.Array.Count.Get();
if index<CAP then
local Player=Players.GetPlayer(index);
local N=Player.Name();
if N==nil then
N="Not Connected Yet...";
end
AddPlayerListIndex(index,"["..NHA_CE.HEX.ConvertFromInt64(Player.Address()).."] "..N,50,true);
else
DeletePlayerListIndex(index);
end
end


function AddPlayerListIndex(index,value)
if GetPlayerUIListCount()<index then
PlayerUI.PlayerList.Items.Add(value);
elseif PlayerUI.PlayerList.Items[index]~=value then
PlayerUI.PlayerList.Items[index]=value;

end
end


function DeletePlayerListIndex(index)
if  index<=GetPlayerUIListCount()  then
PlayerUI.PlayerList.Items.Delete(index);
end
end


function UpdateUIPlayerList()
if Players.ErrorCheck() then
local CAP=Players.Array.Count.Get();
PlayerUI_CurrentPlayersLabel.setCaption("Current Players: "..CAP);
if CAP>0 then
UpdatePlayerListIndex(0);
UpdatePlayerListIndex(1);
UpdatePlayerListIndex(2);
UpdatePlayerListIndex(3);
else
UpdateUIPlayerListNotInGame()
end
else
UpdateUIPlayerListError()
end

end

function GetPlayerUIListCount()
if PlayerUI.PlayerList==nil then
return -1;
else
return PlayerUI.PlayerList.Items.getCount()-1;
end;
end;

function IsPlayerUISelected(PlayerIndex)
if PlayerIndex<=PlayerUI.PlayerList.Items.Count-1 then
return PlayerUI.PlayerList.Selected[PlayerIndex];
else
return false;
end
end

local PrintDebugs=false;
function DebugPrint(printx)
if PrintDebugs then
print(printx);
end
end
function PrintDebugInfo(Value)
PlayerUI.DebugBox.append(Value)
end
function ClearDebugInfo()
PlayerUI.DebugBox.Lines.Clear()
end
ClearDebugInfo();

function UpdateUIPlayerListError()
if Wonderlands.IsAttached then
UpdateUIPlayerListNotInGame();
else
PlayerUI_CurrentPlayersLabel.setCaption("Not Connected!");
DebugPrint("AddPlayerListIndex: 0/"..GetPlayerUIListCount());
AddPlayerListIndex(0,"Please Connect The Table");
DebugPrint("DeletePlayerListIndex: 1/"..GetPlayerUIListCount());
DeletePlayerListIndex(1);
DebugPrint("DeletePlayerListIndex: 2/"..GetPlayerUIListCount());
DeletePlayerListIndex(2);
DebugPrint("DeletePlayerListIndex: 3/"..GetPlayerUIListCount());
DeletePlayerListIndex(3);
end
end

function UpdateUIPlayerListNotInGame()
PlayerUI_CurrentPlayersLabel.setCaption("User Not In Game!");
DebugPrint("AddPlayerListIndex: 0/"..GetPlayerUIListCount());
AddPlayerListIndex(0,"Not In Game!");
DebugPrint("DeletePlayerListIndex: 1/"..GetPlayerUIListCount());
DeletePlayerListIndex(1);
DebugPrint("DeletePlayerListIndex: 2/"..GetPlayerUIListCount());
DeletePlayerListIndex(2);
DebugPrint("DeletePlayerListIndex: 3/"..GetPlayerUIListCount());
DeletePlayerListIndex(3);
end

function PlayerUI_ForeachSelectedPlayer(functionPlayerClass)
local PlayerIndex=0;
ForeachPlayer(function(Player)
if IsPlayerUISelected(PlayerIndex) then
functionPlayerClass(Player);
end
PlayerIndex=PlayerIndex+1;
end);
end

function PlayerUI_PrintPlayerInfoClick(sender)
local PlayerIndex=0;
ClearDebugInfo();
PlayerUI_ForeachSelectedPlayer(function(Player)
PrintDebugInfo("Player Index: "..PlayerIndex);
PrintDebugInfo("Address "..NHA_CE.HEX.ConvertFromInt64(Player.Address()));
PrintDebugInfo("Name: "..Player.Name());
PrintDebugInfo("Team Name: "..Player.TeamName());
PrintDebugInfo("Animation Speed: "..Entity.GlobalAnimationSpeed.Get(Player.PlayerCharacterPath));
PrintDebugInfo("Visible: "..BoolToString(Player.IsVisible.Get() ,"False","True") );
PrintDebugInfo("Money: "..Player.Currency.Money.Get());
PrintDebugInfo("Crystals: "..Player.Currency.Crystals.Get());
PrintDebugInfo("Godmode: "..BoolToString(Player.Godmode.Get() ,"Off","On"));
PrintDebugInfo("Ammo Regen: "..Player.AmmoRegen.Get());
PrintDebugInfo("Gravity: "..Player.Movement.Gravity.Get() );
PrintDebugInfo("Max Jump Count: "..Player.Movement.MaxJumpCount.Get() );
PrintDebugInfo("Walk Speed: "..Player.Movement.MaxWalkSpeed.Get());
PrintDebugInfo("Crouch Speed: "..Player.Movement.MaxCrouchSpeed.Get() );
PrintDebugInfo("Sprint Speed: "..Player.Movement.MaxSprintSpeed.Get());
PrintDebugInfo("Fly: "..BoolToString(Player.FlyEnabled.Get() ,"Off","On"));
PrintDebugInfo("Noclip: "..BoolToString(Player.Noclip.Get() ,"Off","On"));
PrintDebugInfo("Position.X: "..Player.Position.X.Get());
PrintDebugInfo("Position.Y: "..Player.Position.Y.Get());
PrintDebugInfo("Position.Z: "..Player.Position.Z.Get());
PrintDebugInfo(",");
PlayerIndex=PlayerIndex+1;
end);
end

function BoolToString(bool,off,on)
if bool then
return on;
end
return off;
end

function BoolSwap(bool)
if bool then
return false;
else
return true;
end
end

PlayerUI.PlayerList.Items.Clear();


function PlayerUI_GetDefaultValue(ValueRetFunction,ifnil)
if ValueRetFunction==nil then
return ifnil;
end
local DB=nil
PlayerUI_ForeachSelectedPlayer(function(Player)
if DB==nil then;DB=ValueRetFunction(Player);end
end);
if DB==nil then
return ifnil;
else
return DB;
end
end


function PlayerUI_GetFirstSelectedPlayer()
return PlayerUI_GetDefaultValue(function(PC)return PC;end,nil);
end


function PlayerUI_BoolButtonClickHandler(GetBool,SetBool,Refresh)
local DB=PlayerUI_GetDefaultValue(GetBool,false);
local INDEX=0;
PlayerUI_ForeachSelectedPlayer(function(Player)
SetBool(INDEX,Player,BoolSwap(DB));
INDEX=INDEX+1;
end);
Refresh();
end


function PlayerUI_SetupBoolButton(Button,GetFunction,CaptionPrefix)
local State=PlayerUI_GetDefaultValue(GetFunction,false);
Button.setState(State)
Button.setCaption(CaptionPrefix..": "..BoolToString(State,"Off","On"));
end



--[[
    Click Functions
]]

function SetPlayerGodModeValue(PlayerIndex,Player,DB)
Wonderlands.PlayerAutoMod[PlayerIndex+1].GodMode=DB;
Player.Godmode.Set(DB);
end
function OnGodmodeNeeded(PlayerIndex,Player)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].GodMode==true then
Player.Godmode.Set(true);
Player.Health.Fill();
Player.Shield.Fill();
end
end

function PlayerUI_GodBoxClick(sender)
PlayerUI_BoolButtonClickHandler(
function(Player);return Player.Godmode.Get();end,
SetPlayerGodModeValue,
PlayerUI_RefreshGodModeButton);
end



function SetPlayerInfinateAmmo(PlayerIndex,Player,DB)
Wonderlands.PlayerAutoMod[PlayerIndex+1].InfinateAmmo=DB;
if DB then
Player.MaxAmmoRegen();
else
Player.ResetAmmoRegen();
end
end


function OnInfinateAmmoNeeded(PlayerIndex,Player)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].InfinateAmmo==true then
Player.MaxAmmoRegen();
end
end

function PlayerUI_AmmoBoxClick(sender)
PlayerUI_BoolButtonClickHandler(function(Player);return Player.AmmoRegen.Get()~=0;end,
SetPlayerInfinateAmmo,
PlayerUI_RefreshAmmoButton);
end



function PlayerUI_SetPlayerSuperJump(PlayerIndex,Player,DB)
Wonderlands.PlayerAutoMod[PlayerIndex+1].SuperJump=DB;
Player.Movement.SuperJump.Set(DB);
end

function PlayerUI_SuperJumpClick(sender)
PlayerUI_BoolButtonClickHandler(function(Player);return Player.Movement.SuperJump.Get();end,PlayerUI_SetPlayerSuperJump,PlayerUI_RefreshSuperJumpButton);
end

function OnSuperJumpNeeded(PlayerIndex,Player)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].SuperJump==true then
Player.Movement.SuperJump.Set(true);
end
end








function PlayerUI_SetPlayerSuperSpeed(PlayerIndex,Player,DB)
Wonderlands.PlayerAutoMod[PlayerIndex+1].SuperSpeed=DB;
Player.Movement.SuperSpeed.Set(DB)
end


function OnSuperSpeedNeeded(PlayerIndex,Player)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].SuperSpeed==true then
Player.Movement.SuperSpeed.Set(true)
end
end


function PlayerUI_SuperSpeedClick(sender)
PlayerUI_BoolButtonClickHandler(function(Player);return Player.Movement.SuperSpeed.Get();end,PlayerUI_SetPlayerSuperSpeed,PlayerUI_RefreshSuperSpeedButton);
end








function MaxMoneyHandler(PlayerIndex,Player,bool)
Wonderlands.PlayerAutoMod[PlayerIndex+1].MaxMoney=bool;
if bool then
Player.Currency.MaxAll();
else
Player.Currency.Money.Set(Player.Currency.Money.Get()-1)
end
end

function OnMaxMoneyNeeded(PlayerIndex,Player)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].MaxMoney==true then
Player.Currency.MaxAll()
end
end

function PlayerUI_MoneyBoxClick(sender)
PlayerUI_BoolButtonClickHandler(function(Player);return Player.Currency.Money.Get()==Player.Currency.MaxInteger;end,MaxMoneyHandler,PlayerUI_RefreshMoneyBoxButton);
end





function NoclipHandler(PlayerIndex,Player,DB)
Wonderlands.PlayerAutoMod[PlayerIndex+1].Noclip=DB;
Player.NoclipAndFly.Set(DB);
end

function OnNoclipNeeded(PlayerIndex,Player)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].Noclip==true then
Player.NoclipAndFly.Set(true);
end
end

function PlayerUI_FlyBoxClick(sender)
PlayerUI_BoolButtonClickHandler(function(Player);return Player.NoclipAndFly.Get();end,NoclipHandler,PlayerUI_RefreshFlyBoxButton);
end






function PlayerUI_DamageHandler(PlayerIndex,Player,DB)
Wonderlands.PlayerAutoMod[PlayerIndex+1].Damage=DB;
if DB then
Player.MaxDamageModifier();
Player.MaxCriticalChance();
else
Player.ResetDamageModifier();
Player.ResetCriticalChance();
end
end

function OnDamageNeeded(PlayerIndex,Player)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].Damage==true then
Player.MaxDamageModifier();
Player.MaxCriticalChance();
end
end


function PlayerUI_DamageBoxClick(sender)
PlayerUI_BoolButtonClickHandler(function(Player);return Player.DamageModifier.Get()>2 and Player.CriticalChance.Get()>2;end,PlayerUI_DamageHandler,PlayerUI_RefreshDamageBoxButton);
end




function NoTargetHandler(PlayerIndex,Player,DB)
Wonderlands.PlayerAutoMod[PlayerIndex+1].NoTarget=DB;
end

function OnNoTargetNeeded(PlayerIndex,Player)
local DB=Wonderlands.PlayerAutoMod[PlayerIndex+1].NoTarget;
Player.IsTargetable.Set(DB);
Player.IsVisible.Set(DB);
end

PlayerUI_NotargetGet=function(Player);
return  Player.IsTargetable.Get() and 
Player.IsVisible.Get();
end;

function PlayerUI_NoTargetBoxClick(sender)
PlayerUI_BoolButtonClickHandler(PlayerUI_NotargetGet,NoTargetHandler,PlayerUI_RefreshNoTargetBoxButton);
end





--[[
    Refresh Functions
]]
function PlayerUI_RefreshGodModeButton()
PlayerUI_SetupBoolButton(PlayerUI.GodBox,function(Player);return Player.Godmode.Get();end,"God Mode");
end

function PlayerUI_RefreshAmmoButton()
PlayerUI_SetupBoolButton(PlayerUI.AmmoBox,function(Player);return Player.AmmoRegen.Get()~=0;end,"Infinate Ammo");
end


function PlayerUI_RefreshSuperSpeedButton()
PlayerUI_SetupBoolButton(PlayerUI.SuperSpeed,function(Player);return Player.Movement.SuperSpeed.Get();end,"Super Speed");
end

function PlayerUI_RefreshSuperJumpButton()
PlayerUI_SetupBoolButton(PlayerUI.SuperJump,function(Player);return Player.Movement.SuperJump.Get();end,"Super Jump");
end

function PlayerUI_RefreshFlyBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.FlyBox,function(Player);return Player.NoclipAndFly.Get();end,"Fly And Noclip");
end


function PlayerUI_RefreshMoneyBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.MoneyBox,function(Player);return Player.Currency.Money.Get()==Player.Currency.MaxInteger;end,"Max Money");
end

function PlayerUI_RefreshDamageBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.DamageBox,function(Player);return Player.DamageModifier.Get()>2 and Player.CriticalChance.Get()>2;end,"Max Damage");
end


function PlayerUI_RefreshInvisibleBoxButton()
PlayerUI.InvisibleBox.Enabled=false;
PlayerUI.InvisibleBox.Visible=false;
end
function PlayerUI_RefreshNoTargetBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.NoTargetBox,PlayerUI_NotargetGet,"No Target");
end



function PlayerUI_SetHealthClick(sender)
local NUM=tonumber(PlayerUI.HealthModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Health.CurrentValue.Set(NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_SetMaxHealthClick(sender)
local NUM=tonumber(PlayerUI.MaxHealthModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Health.MaxValue.Set(NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_SetSheildClick(sender)
local NUM=tonumber(PlayerUI.SheildModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Shield.CurrentValue.Set(NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_SetMaxSheildClick(sender)
local NUM=tonumber(PlayerUI.MaxSheildModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Shield.MaxValue.Set(NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_ReloadHP_Values()
local Player=PlayerUI_GetFirstSelectedPlayer();
if Player~=nil then
PlayerUI.HealthModifier.setCaption(Player.Health.CurrentValue.Get());
PlayerUI.MaxHealthModifier.setCaption(Player.Health.MaxValue.Get());
PlayerUI.SheildModifier.setCaption(Player.Shield.CurrentValue.Get());
PlayerUI.MaxSheildModifier.setCaption(Player.Shield.MaxValue.Get());
else
PlayerUI.HealthModifier.setCaption(0);
PlayerUI.MaxHealthModifier.setCaption(0);
PlayerUI.SheildModifier.setCaption(0);
PlayerUI.MaxSheildModifier.setCaption(0);
end
end



function PlayerUI_PlayerListSelectionChange(sender, user)
PlayerUI_RefreshGodModeButton();
PlayerUI_RefreshAmmoButton();
PlayerUI_RefreshSuperSpeedButton();
PlayerUI_RefreshSuperJumpButton();
PlayerUI_RefreshFlyBoxButton();
PlayerUI_RefreshMoneyBoxButton();
PlayerUI_RefreshDamageBoxButton();
PlayerUI_RefreshInvisibleBoxButton();
PlayerUI_RefreshNoTargetBoxButton();
PlayerUI_ReloadHP_Values();
PlayerUI_ReloadPetClasses();
end


function PlayerUI_MushroomPetSpawnClick(sender)
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Pets.DuplicatePet(0);
end);
end

function PlayerUI_DemiLichPetSpawnClick(sender)
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Pets.DuplicatePet(1);
end);
end

function PlayerUI_WyvernPetSpawnClick(sender)
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Pets.DuplicatePet(2);
end);
end

function PlayerUI_PetsSetClassesClick(sender)
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Pets.PetClass.Set(0,GetAddress(PlayerUI.MushroomPetClass.Text));
Player.Pets.PetClass.Set(1,GetAddress(PlayerUI.DemiLichPetClass.Text));
Player.Pets.PetClass.Set(2,GetAddress(PlayerUI.WyvernPetClass.Text));

end);
PlayerUI_ReloadPetClasses();
end

function PlayerUI_ReloadPetClasses()
PlayerUI.MushroomPetClass.Text=NHA_CE.HEX.ConvertFromInt64(PlayerUI_GetDefaultValue(function(Player);return
Player.Pets.PetClass.Get(0);end,0x00000000));

PlayerUI.DemiLichPetClass.Text=NHA_CE.HEX.ConvertFromInt64(PlayerUI_GetDefaultValue(function(Player);return
Player.Pets.PetClass.Get(1);end,0x00000000));

PlayerUI.WyvernPetClass.Text=NHA_CE.HEX.ConvertFromInt64(PlayerUI_GetDefaultValue(function(Player);return
Player.Pets.PetClass.Get(2);end,0x00000000));

end


function PlayerUI_RefreshPetValuesClick(sender)
PlayerUI_ReloadPetClasses();
end


