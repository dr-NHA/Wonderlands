
function PlayerUI_FormClose(sender)

return caHide --Possible options: caHide, caFree, caMinimize, caNone
end

function OpenPlayerUI(memrec)
FixSyncIssue(function()
if PlayerUI.isForegroundWindow()==false then
PlayerUI.centerScreen();
PlayerUI.bringToFront();
PlayerUI.Show();
end
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
if GetPlayerCheck() then
PlayerIndex=0;
ForeachPlayer(function(PlayerClass)
Wonderlands.PlayerAutoModFunction(PlayerIndex,PlayerClass);
PlayerIndex=PlayerIndex+1;
end);
end
end


function Wonderlands.PlayerAutoModFunction(PlayerIndex,PlayerClass)
OnGodmodeNeeded(PlayerIndex,PlayerClass);
OnInfinateAmmoNeeded(PlayerIndex,PlayerClass);
OnSuperJumpNeeded(PlayerIndex,PlayerClass);
OnSuperSpeedNeeded(PlayerIndex,PlayerClass);
OnMaxMoneyNeeded(PlayerIndex,PlayerClass);
OnNoclipNeeded(PlayerIndex,PlayerClass);
OnDamageNeeded(PlayerIndex,PlayerClass);
OnInvisibleNeeded(PlayerIndex,PlayerClass);
OnNoTargetNeeded(PlayerIndex,PlayerClass);
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
local CAP=ReadInteger(PlayerArrayCount());
if index<CAP then
local PlayerAddress=NHA_CE.HEX.GetAddress(ReadPointer(GetPlayerX(index)));
local N=GetPlayerName(PlayerAddress);
if N==nil then
N="Not Connected Yet...";
end
AddPlayerListIndex(index,"["..PlayerAddress.."] "..N,50,true);


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
if GetPlayerCheck() then
local CAP=ReadInteger(PlayerArrayCount());
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
ForeachPlayer(function(PlayerClass)
if IsPlayerUISelected(PlayerIndex) then
functionPlayerClass(PlayerClass);
end
PlayerIndex=PlayerIndex+1;
end);
end

function PlayerUI_PrintPlayerInfoClick(sender)
local PlayerIndex=0;
ClearDebugInfo();
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
local PlayerAddress=NHA_CE.HEX.GetAddress(ReadPointer(PlayerClass));
PrintDebugInfo("Player Index: "..PlayerIndex);
PrintDebugInfo("Address "..PlayerAddress);
PrintDebugInfo("Name: "..GetPlayerName(PlayerAddress));
PrintDebugInfo("Team Name: "..GetPlayerTeamName(PlayerClass));
PrintDebugInfo("Animation Speed: "..GetGlobalAnimationSpeed(PlayerClass));
PrintDebugInfo("Visible: "..BoolToString(IsPlayerVisible(PlayerClass) ,"False","True") );
PrintDebugInfo("Money: "..GetPlayerMoney(PlayerClass));
PrintDebugInfo("Crystals: "..GetPlayerCrystals(PlayerClass));
PrintDebugInfo("Godmode: "..BoolToString(GetPlayerGodmode(PlayerClass) ,"Off","On"));
local RGN=GetPlayerAmmoRegen(PlayerClass);
PrintDebugInfo("Ammo Regen: "..BoolToString(RGN<1,BoolToString(RGN==1000000000,RGN,"Maximum"),"Default"));
PrintDebugInfo("Gravity: "..BoolToString(GetGravity(PlayerClass)~=1 ,"Default",GetGravity(PlayerClass)) );
PrintDebugInfo("Max Jump Count: "..BoolToString(GetPlayerMaxJumpCount(PlayerClass)~=1 ,"Default",GetPlayerMaxJumpCount(PlayerClass)) );
PrintDebugInfo("Walk Speed: "..BoolToString(GetMaxWalkSpeed(PlayerClass)~=470 ,"Default",GetMaxWalkSpeed(PlayerClass)));
PrintDebugInfo("Crouch Speed: "..BoolToString(GetMaxCrouchSpeed(PlayerClass)~=275 ,"Default",GetMaxCrouchSpeed(PlayerClass)) );
PrintDebugInfo("Sprint Speed: "..BoolToString(GetMaxSprintSpeed(PlayerClass)~=720 ,"Default",GetMaxSprintSpeed(PlayerClass)) );
PrintDebugInfo("Fly: "..BoolToString(GetPlayerFlyMode(PlayerClass) ,"Off","On"));
PrintDebugInfo("Noclip: "..BoolToString(GetPlayerNoclip(PlayerClass) ,"Off","On"));
PrintDebugInfo("Position.X: "..GetEntityPositionX(PlayerClass));
PrintDebugInfo("Position.Y: "..GetEntityPositionY(PlayerClass));
PrintDebugInfo("Position.Z: "..GetEntityPositionZ(PlayerClass));
local DB=NHA_CE.HEX.ConvertFromInt64(GetLastHitBy(PlayerClass));
if DB=="00" then
DB="Nobody!";
end
PrintDebugInfo("Last Hit By: "..DB);
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
local DB=nil
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
if DB==nil then;DB=ValueRetFunction(PlayerClass);end
end);
if DB==nil then
return ifnil;
else
return DB;
end
end


function PlayerUI_GetFirstSelectedPlayerClass()
return PlayerUI_GetDefaultValue(function(PC)return PC;end,nil);
end


function PlayerUI_BoolButtonClickHandler(GetBool,SetBool,Refresh)
local DB=PlayerUI_GetDefaultValue(GetBool,false);
local INDEX=0;
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
SetBool(INDEX,PlayerClass,BoolSwap(DB));
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

function SetPlayerGodModeValue(Index,PlayerClass,DB)
Wonderlands.PlayerAutoMod[Index+1].GodMode=DB;
if DB then
EnablePlayerGodmode(PlayerClass);
else
DisablePlayerGodmode(PlayerClass);
end
end
function OnGodmodeNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].GodMode==true then
EnablePlayerGodmode(PlayerClass);
end
end

function PlayerUI_GodBoxClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerGodmode,SetPlayerGodModeValue,PlayerUI_RefreshGodModeButton);
end







function SetPlayerInfinateAmmo(Index,PlayerClass,DB)
Wonderlands.PlayerAutoMod[Index+1].InfinateAmmo=DB;
if DB then
SetPlayerMaxAmmoRegen(PlayerClass);
else
SetPlayerNoAmmoRegen(PlayerClass);
end
end


function OnInfinateAmmoNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].InfinateAmmo==true then
SetPlayerMaxAmmoRegen(PlayerClass);
end
end


function GetPlayerInfinateAmmo(PlayerClass)
return GetPlayerAmmoRegen(PlayerClass)~=0;
end

function PlayerUI_AmmoBoxClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerInfinateAmmo,SetPlayerInfinateAmmo,PlayerUI_RefreshAmmoButton);
end







function PlayerUI_SetPlayerSuperJump(Index,PlayerClass,DB)
Wonderlands.PlayerAutoMod[Index+1].SuperJump=DB;
SetPlayerSuperJump(PlayerClass,DB);
end

function PlayerUI_SuperJumpClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerSuperJump,PlayerUI_SetPlayerSuperJump,PlayerUI_RefreshSuperJumpButton);
end

function OnSuperJumpNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].SuperJump==true then
SetPlayerSuperJump(PlayerClass,true);
end
end








function PlayerUI_SetPlayerSuperSpeed(Index,PlayerClass,DB)
Wonderlands.PlayerAutoMod[Index+1].SuperSpeed=DB;
SetPlayerSuperSpeed(PlayerClass,Wonderlands.PlayerAutoMod[Index+1].SuperSpeed);
end


function OnSuperSpeedNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].SuperSpeed==true then
SetPlayerSuperSpeed(PlayerClass,true);
else
if GetPlayerSuperSpeed(PlayerClass)==true then
SetPlayerSuperSpeed(PlayerClass,false);
end
end
end


function PlayerUI_SuperSpeedClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerSuperSpeed,PlayerUI_SetPlayerSuperSpeed,PlayerUI_RefreshSuperSpeedButton);
end








function MaxMoneyHandler(Index,PlayerClass,bool)
Wonderlands.PlayerAutoMod[PlayerIndex+1].MaxMoney=bool;
if bool then
MaxPlayerMoney(PlayerClass);
MaxPlayerCrystals(PlayerClass);
MaxPlayerSouls(PlayerClass);
MaxPlayerRainbowGems(PlayerClass);
else
SetPlayerMoney(PlayerClass,GetPlayerMoney(PlayerClass)-1)
end
end

function OnMaxMoneyNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].MaxMoney==true then
SetPlayerSuperSpeed(PlayerClass,true);
end
end

function PlayerUI_MoneyBoxClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerMaxMoney,MaxMoneyHandler,PlayerUI_RefreshMoneyBoxButton);
end





function NoclipHandler(Index,PlayerClass,bool)
Wonderlands.PlayerAutoMod[Index+1].Noclip=bool;
SetFlyAndNoclip(PlayerClass,bool);
end

function OnNoclipNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].Noclip==true then
SetFlyAndNoclip(PlayerClass,true);
end
end


function PlayerUI_FlyBoxClick(sender)
PlayerUI_BoolButtonClickHandler(GetFlyAndNoclip,NoclipHandler,PlayerUI_RefreshFlyBoxButton);
end






function DamageHandler(Index,PlayerClass,bool)
Wonderlands.PlayerAutoMod[PlayerIndex+1].Damage=bool;
SetPlayerMaxDamage(PlayerClass,bool);
end

function OnDamageNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].Damage==true then
if GetPlayerMaxDamage(PlayerClass)==false then
SetPlayerMaxDamage(PlayerClass,true);
end
end
end


function PlayerUI_DamageBoxClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerMaxDamage,DamageHandler,PlayerUI_RefreshDamageBoxButton);
end








function InvisibleHandler(Index,PlayerClass,bool)
Wonderlands.PlayerAutoMod[PlayerIndex+1].Invisible=bool;
SetPlayerVisibility(PlayerClass,bool);
end

function OnInvisibleNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].Invisible==true then
SetPlayerVisibility(PlayerClass,true);
end
end

function PlayerUI_InvisibleBoxClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerVisibility,InvisibleHandler,PlayerUI_RefreshDamageBoxButton);
PlayerUI_RefreshInvisibleBoxButton();
end



function NoTargetHandler(Index,PlayerClass,bool)
Wonderlands.PlayerAutoMod[PlayerIndex+1].NoTarget=bool;
SetPlayerNoTarget(PlayerClass,bool);
end

function OnNoTargetNeeded(PlayerIndex,PlayerClass)
if Wonderlands.PlayerAutoMod[PlayerIndex+1].NoTarget==true then
SetPlayerNoTarget(PlayerClass,true);
end
end

function PlayerUI_NoTargetBoxClick(sender)
PlayerUI_BoolButtonClickHandler(GetPlayerNoTarget,NoTargetHandler,PlayerUI_RefreshNoTargetBoxButton);
end





--[[
    Refresh Functions
]]
function PlayerUI_RefreshGodModeButton()
PlayerUI_SetupBoolButton(PlayerUI.GodBox,GetPlayerGodmode,"God Mode");
end

function PlayerUI_RefreshAmmoButton()
PlayerUI_SetupBoolButton(PlayerUI.AmmoBox,function(PlayerClass);return GetPlayerAmmoRegen(PlayerClass)~=0;end,"Infinate Ammo");
end


function PlayerUI_RefreshSuperSpeedButton()
PlayerUI_SetupBoolButton(PlayerUI.SuperSpeed,GetPlayerSuperSpeed,"Super Speed");
end

function PlayerUI_RefreshSuperJumpButton()
PlayerUI_SetupBoolButton(PlayerUI.SuperJump,GetPlayerSuperJump,"Super Jump");
end

function PlayerUI_RefreshFlyBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.FlyBox,GetFlyAndNoclip,"Fly And Noclip");
end


function PlayerUI_RefreshMoneyBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.MoneyBox,GetPlayerMaxMoney,"Max Money");
end

function PlayerUI_RefreshDamageBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.DamageBox,GetPlayerMaxDamage,"Max Damage");
end


function PlayerUI_RefreshInvisibleBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.InvisibleBox,GetPlayerVisibility,"Is Visible");
end
function PlayerUI_RefreshNoTargetBoxButton()
PlayerUI_SetupBoolButton(PlayerUI.NoTargetBox,GetPlayerNoTarget,"No Target");
end



function PlayerUI_SetHealthClick(sender)
local NUM=tonumber(PlayerUI.HealthModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
SetPlayerHealth(PlayerClass,NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_SetMaxHealthClick(sender)
local NUM=tonumber(PlayerUI.MaxHealthModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
SetPlayerMaxHealth(PlayerClass,NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_SetSheildClick(sender)
local NUM=tonumber(PlayerUI.SheildModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
SetPlayerShield(PlayerClass,NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_SetMaxSheildClick(sender)
local NUM=tonumber(PlayerUI.MaxSheildModifier.Text);
PlayerUI_ForeachSelectedPlayer(function(PlayerClass)
SetPlayerMaxShield(PlayerClass,NUM);
end);
PlayerUI_ReloadHP_Values();
end

function PlayerUI_ReloadHP_Values()
local PlayerClass=PlayerUI_GetFirstSelectedPlayerClass();
if PlayerClass~=nil then
PlayerUI.HealthModifier.setCaption(GetPlayerHealth(PlayerClass));
PlayerUI.MaxHealthModifier.setCaption(GetPlayerMaxHealth(PlayerClass));
PlayerUI.SheildModifier.setCaption(GetPlayerShield(PlayerClass));
PlayerUI.MaxSheildModifier.setCaption(GetPlayerMaxShield(PlayerClass));
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
