
--Get If A Player Is Visible
function PlayerAutoPossessAI(PlayerClass)
return readByte('['..PlayerClass..']+469')
end


function IsPlayer(PlayerClass)
if PlayerClass==nil then
return false;
else
return readPointer("["..PlayerClass.."]+9C0")~=0 and PlayerAutoPossessAI(PlayerClass)==0;
end
end


function Is_AI(PlayerClass)
if PlayerClass==nil then
return false;
else
return readPointer("["..PlayerClass.."]+9C0")==0 and (
PlayerAutoPossessAI(PlayerClass)>0 and
PlayerAutoPossessAI(PlayerClass)<5
);
end
end

function IsUnknownEntity(PlayerClass)
if PlayerClass==nil then
return false;
else
return PlayerAutoPossessAI(PlayerClass)==163
end
end

function DoIfPlayerIsntNull(player,action)
if player~=nil then
action(player);
end;
end


local TP_Position_Set=false;
local TP_Position_X=0;
local TP_Position_Y=0;
local TP_Position_Z=0;
function Set_TP_Position(X,Y,Z)
TP_Position_X=X;
TP_Position_Y=Y;
TP_Position_Z=Z;
TP_Position_Set=true;
end

function Set_TP_Position_FromPlayer0()
local Player=GetPlayerX(0);
Set_TP_Position(
GetEntityPositionX(Player),
GetEntityPositionY(Player),
GetEntityPositionZ(Player));
end

function TP_To_Position(PlayerClass)
if PlayerClass~=nil and
TP_Position_Set then
SetEntityPositionX(PlayerClass,TP_Position_X);
SetEntityPositionY(PlayerClass,TP_Position_Y);
SetEntityPositionZ(PlayerClass,TP_Position_Z);
end;end




function GetPlayerTeamName(PlayerClass)
return readString('[[[['..PlayerClass..']+908]+180]+30]',30,true);
end

function IsAllyTeam(PlayerClass)
local STER=readString('[[[['..PlayerClass..']+908]+180]+30]',30,true);
return STER=="Players" or STER=="NonPlayers" or
TEM=="Friendly to All";
end

function IsEnemyTeam(PlayerClass)
local TEM=readString('[[[['..PlayerClass..']+908]+180]+30]',30,true);
return NHA_CE.String.StartsWith(TEM, "Team_") or
TEM=="PlayerHaters" or
TEM=="Enemies"
;
end



--[[

Player Function Helpers

]]

--Function To Easily Get The String Path To The Player Array
function PlayerArray()
return getAddress("[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]");
end

function GetPlayerCheck()
return Wonderlands.PointerChecksOut("[[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]+0]+118]+498");
end

function GetPlayer(index)
local ADDRESS=getAddress("[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]".."+"..List_IndexToHex(index));
if ADDRESS==nil then
return List_IndexToHex(index);
else
return ADDRESS;
end;end

function GetPlayer_CE(index)
if GetPlayerCheck() then
 local ADDRESS=getAddress(
"[[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]+"..List_IndexToHex(index).."]+118]+498");
if ADDRESS==nil then
return List_IndexToHex(index);
else
return ADDRESS;
end;
else
return nil
end
end


function GetPlayerX(index)
if GetPlayerCheck() then
local ADDRESS=NHA_CE.HEX.GetAddress(
"[[[RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray]+"..List_IndexToHex(index).."]+118]+498");
if ADDRESS=="0" then
return List_IndexToHex(index);
else
return ADDRESS;
end
else
return nil
end
end

function GetPlayersTargetNPC(index)
if GetPlayerCheck() then
 local ADDRESS=getAddress("[[["..GetPlayer(index).."]+118]+970]+40")
 if ADDRESS=="0" then
return 0;
else
return ADDRESS;
end
else
return nil
end
end

function PlayerArrayCount()
return GetAddress("RefBPGameState_Default_C()+BPGameState_Default_C.PlayerArray_size")
end


--Does An Action With Each Player
function ForeachPlayer(action)
if GetPlayerCheck() then
local C=ReadInteger(PlayerArrayCount());
if C~=nil then
ForeachBuilder(GetPlayerX,C-1,function(playerclass)
if playerclass~=nil then
if playerclass~=0 then
action(playerclass);
end
end
end);
end
end
end




--[[
Last Hit By Functions
]]
function SetLastHitBy(PlayerClass,AttackerClass)
if IsPlayer(AttackerClass) or Is_AI(AttackerClass) then
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WritePointer("["..PlayerClass.."]+488","["..AttackerClass.."]");
end)
end
end

function GetLastHitBy(PlayerClass)
return ReadPointer("["..PlayerClass.."]+488");
end

function NullLastHitBy(PlayerClass)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WritePointer("["..PlayerClass.."]+488",0);
end)
end






--[[

Player Function Helpers

]]

--[[Visibility Modifiers]]

--Set If A Player Is Visible
function PlayerVisible(PlayerClass,boolean)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
if boolean then
writeInteger('[[[[['..PlayerClass..']+118]+498]+490]+950]+26C',1)
else
writeInteger('[[[[['..PlayerClass..']+118]+498]+490]+950]+26C',0)
end
end);
end

--Get If A Player Is Visible
function IsPlayerVisible(PlayerClass)
return readInteger('[[[[['..PlayerClass..']+118]+498]+490]+950]+26C')==1
end

--Show The Player
function HidePlayer(PlayerClass);
PlayerVisible(PlayerClass,false);
end

--Show The Player
function ShowPlayer(PlayerClass);
PlayerVisible(PlayerClass,true);
end




--[[Damage Modifiers]]

--Set The Players Damage
function SetPlayerDamage(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[[['..PlayerClass..']+118]+498]+EC8]+2C8',value)
end);
end

--Get The Players Current Damage Value
function GetPlayerDamage(PlayerClass)
return readFloat('[[[['..PlayerClass..']+118]+498]+EC8]+2C8');
end


--Set The Players Damage To The Maximum
function MAX_PlayerDamage(PlayerClass);
PlayerDamage(PlayerClass,9999999);end

--Reset The Players Damage
function RESET_PlayerDamage(PlayerClass);
PlayerDamage(PlayerClass,1.090000033);end




--[[Critical Chance Modifiers]]

--Set The Players Crit Chance
function SetPlayerCritChance(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[[['..PlayerClass..']+118]+498]+EC8]+31C',value)
end);
end

--Get The Players Current Crit Chance Value
function GetPlayerCritChance(PlayerClass)
return readFloat('[[[['..PlayerClass..']+118]+498]+EC8]+31C');
end

--Set The Players Crit Chance To The Maximum
function MAX_PlayerCritChance(PlayerClass);
PlayerCritChance(PlayerClass,9999999);end

--Reset The Players Crit Chance
function RESET_PlayerCritChance(PlayerClass);
PlayerCritChance(PlayerClass,0.05000000075);end


--[[

]]
function GetPlayerMaxDamage(PlayerClass);
return GetPlayerDamage(PlayerClass)==9999999 and
GetPlayerCritChance(PlayerClass)==9999999;
end

function SetPlayerMaxDamage(PlayerClass,value);
if value then
SetPlayerDamage(PlayerClass,9999999)
SetPlayerCritChance(PlayerClass,9999999);
else
SetPlayerDamage(PlayerClass,1.090000033)
SetPlayerCritChance(PlayerClass,0.05000000075)
end
end



function GetGlobalAnimationSpeed(PlayerClass)
return readFloat('[['..PlayerClass..']+4C0]+B30');
end

function SetGlobalAnimationSpeed(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[['..PlayerClass..']+4C0]+B30',value);
end);
end

function SetFreezeState(PlayerClass,value)
if value then
SetGlobalAnimationSpeed(PlayerClass,0);
else
SetGlobalAnimationSpeed(PlayerClass,1);
end
end

function FreezePlayer(PlayerClass)
SetFreezeState(PlayerClass,true);
end

function DeFreezePlayer(PlayerClass)
SetFreezeState(PlayerClass,false);
end

function SlowModePlayer(PlayerClass)
SetGlobalAnimationSpeed(PlayerClass,0.2);
end


--[[
Health Functions
]]

function GetPlayerHealthOffset(PlayerClass)
if IsPlayer(PlayerClass) then;
return "198";
else
return "A0";
end
end


function SetPlayerHealth(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerHealthOffset(PlayerClass),value);
writeFloat('[[['..PlayerClass..']+EB8]+180]+198',value);--Incase?
end);
end

function GetPlayerHealth(PlayerClass)
return readFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerHealthOffset(PlayerClass));
end

function SetPlayerMaxHealth(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerHealthOffset(PlayerClass).."+C",value);
writeFloat('[[['..PlayerClass..']+EB8]+180]+198+C',value);--Incase?
end);
end

function GetPlayerMaxHealth(PlayerClass)
return readFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerHealthOffset(PlayerClass).."+C");
end

function SetPlayerHealthRegen(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerHealthOffset(PlayerClass).."+14",value);
writeFloat('[[['..PlayerClass..']+EB8]+180]+198+14',value);--Incase?
end);
end

function GetPlayerHealthRegen(PlayerClass)
return readFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerHealthOffset(PlayerClass).."+14");
end

function SetHealthToOneIfAboveOne(PlayerClass)
if PlayerClass~=nil then
local HP=GetPlayerHealth(PlayerClass);
if HP~=nil then
if HP>2 then
SetPlayerHealth(PlayerClass,2);
end
end
end
end

function SetHealthToMax(PlayerClass)
SetPlayerHealth(PlayerClass,GetPlayerMaxHealth(PlayerClass));
end



--[[
Shield Functions
]]

function GetPlayerShieldOffset(PlayerClass)
if IsPlayer(PlayerClass) then;
return "290";
else
return "198";
end
end

function SetPlayerShield(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerShieldOffset(PlayerClass),value);
end);
end

function GetPlayerShield(PlayerClass)
return readFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerShieldOffset(PlayerClass));
end

function SetPlayerMaxShield(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerShieldOffset(PlayerClass).."+C",value);
end);
end

function GetPlayerMaxShield(PlayerClass)
return readFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerShieldOffset(PlayerClass).."+C");
end

function SetPlayerShieldRegen(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
writeFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerShieldOffset(PlayerClass).."+14",value);
end);
end

function GetPlayerShieldRegen(PlayerClass)
return readFloat('[[['..PlayerClass..']+EB8]+180]+'..GetPlayerShieldOffset(PlayerClass).."+14");
end

function SetShieldToOneIfAboveOne(PlayerClass)
if PlayerClass~=nil then
local HP=GetPlayerShield(PlayerClass);
if HP~=nil then
if HP>2 then
SetPlayerShield(PlayerClass,2);
end
end
end
end

function SetShieldToMax(PlayerClass)
SetPlayerShield(PlayerClass,GetPlayerMaxShield(PlayerClass));
end



function AutoKillEnemy(PlayerClass)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
--SetShieldToOneIfAboveOne(PlayerClass);
local HP=GetPlayerShield(PlayerClass);
if HP~=nil then
if HP > 0 then
HP=HP*1337
SetPlayerShieldRegen(PlayerClass,1-HP);
end;end
HP=GetPlayerHealth(PlayerClass);
if HP~=nil then
if HP > 0 then
HP=HP*1337
--SetHealthToOneIfAboveOne(PlayerClass);
SetPlayerHealthRegen(PlayerClass,1-HP);
end;end
end);
end




function UnKillEnemy(PlayerClass)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
SetPlayerShield(PlayerClass,999999999);
SetPlayerShieldRegen(PlayerClass,0);
SetPlayerHealth(PlayerClass,999999999);
SetPlayerHealthRegen(PlayerClass,0);
end)
end


function SetPlayerHealthToLeetSpeak(PlayerClass)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
SetPlayerShield(PlayerClass,133333337+2);
SetPlayerHealth(PlayerClass,133333337+2);
SetPlayerShieldRegen(PlayerClass,13337.1337);
SetPlayerHealthRegen(PlayerClass,13337.1337);
end)
end


--[[
Position Functions
]]

function PositionOffset0(PlayerClass)
if IsUnknownEntity(PlayerClass) or Is_AI(PlayerClass) then
return "+168";
else
return "+4D0";
end
end

--Set X
function SetEntityPositionX(PlayerClass,x)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteFloat('[['..PlayerClass..']'..PositionOffset0(PlayerClass)..']+220',x);
end);
end;
--Get X
function GetEntityPositionX(PlayerClass)
local DB=0;
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
DB=readFloat('[['..PlayerClass..']'..PositionOffset0(PlayerClass)..']+220');
end);
return DB;
end
--Set Y
function SetEntityPositionY(PlayerClass,y)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteFloat('[['..PlayerClass..']'..PositionOffset0(PlayerClass)..']+224',y);
end);
end;
--Get Y
function GetEntityPositionY(PlayerClass)
local DB=0;
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
DB=readFloat('[['..PlayerClass..']'..PositionOffset0(PlayerClass)..']+224');
end);
return DB;
end
--Set Z
function SetEntityPositionZ(PlayerClass,z)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteFloat('[['..PlayerClass..']'..PositionOffset0(PlayerClass)..']+228',z);
end);
end;
--Get Z
function GetEntityPositionZ(PlayerClass)
local DB=0;
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
DB=readFloat('[['..PlayerClass..']'..PositionOffset0(PlayerClass)..']+228');
end);
return DB;
end


--[[
Ammo Functions
]]

function SetPlayerAmmoRegen(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteFloat('['..PlayerClass..']+PlayerController.AmmoRegenRate',value);
end);
end;

function GetPlayerAmmoRegen(PlayerClass)
return readFloat('['..PlayerClass..']+PlayerController.AmmoRegenRate');
end

function SetPlayerMaxAmmoRegen(PlayerClass)
SetPlayerAmmoRegen(PlayerClass,999999999);
end;

function SetPlayerNoAmmoRegen(PlayerClass)
SetPlayerAmmoRegen(PlayerClass,0);
end;





--[[
Money Functions
]]
Wonderlands.GlobalMaxCurrencyInteger=2133333337;


function GetPlayerMoneyAddress(PlayerClass)
return '[[['..PlayerClass..']+EE0]+228]+18';
end

function SetPlayerMoney(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteInteger(GetPlayerMoneyAddress(PlayerClass),value);
end)
end;
function GetPlayerMoney(PlayerClass)
return readInteger(GetPlayerMoneyAddress(PlayerClass));
end


function MaxPlayerMoney(PlayerClass)
SetPlayerMoney(PlayerClass,Wonderlands.GlobalMaxCurrencyInteger);
end

function RemovePlayerMoney(PlayerClass)
SetPlayerMoney(PlayerClass,0);
end



--[[
Crystals Functions
]]

function GetPlayerCrystalsAddress(PlayerClass)
return '[[['..PlayerClass..']+EE0]+228]+90';
end

function SetPlayerCrystals(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteInteger(GetPlayerCrystalsAddress(PlayerClass),value);
end)
end;

function GetPlayerCrystals(PlayerClass)
return readInteger(GetPlayerCrystalsAddress(PlayerClass));
end


function MaxPlayerCrystals(PlayerClass)
SetPlayerCrystals(PlayerClass,Wonderlands.GlobalMaxCurrencyInteger);
end

function RemovePlayerCrystals(PlayerClass)
SetPlayerCrystals(PlayerClass,0);
end


--[[
Check If Player Has Max Money
]]

function GetPlayerMaxMoney(PlayerClass)
return GetPlayerMoney(PlayerClass)==Wonderlands.GlobalMaxCurrencyInteger and
GetPlayerCrystals(PlayerClass)==Wonderlands.GlobalMaxCurrencyInteger;
end


--[[
Souls Functions
]]

function GetPlayerSoulsAddress(PlayerClass)
return '[[['..PlayerClass..']+EE0]+228]+180';
end

function SetPlayerSouls(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteInteger(GetPlayerSoulsAddress(PlayerClass),value);
end)
end;

function GetPlayerSouls(PlayerClass)
return readInteger(GetPlayerSoulsAddress(PlayerClass));
end


function MaxPlayerSouls(PlayerClass)
SetPlayerSouls(PlayerClass,Wonderlands.GlobalMaxCurrencyInteger);
end

function RemovePlayerSouls(PlayerClass)
SetPlayerSouls(PlayerClass,0);
end



--[[
Rainbow Gems Functions
]]
Wonderlands.GlobalMaxRainbowGemsInteger=133333337;


function GetInventoryDataIndexId(index)
return  0x78*index;
end
function GetInventoryDataAddress(PlayerClass,index)
return getAddress("[[["..PlayerClass.."]+EE0]+228]+"..NHA_CE.HEX.ConvertFromInt64( GetInventoryDataIndexId(index)));
 end

function GetInventoryDataQuanityAddress(PlayerClass,index)
return GetInventoryDataAddress(PlayerClass,index)+0x18;
 end

function GetInventoryDataReplicationId(PlayerClass,index)
return readInteger(GetInventoryDataAddress(PlayerClass,index));
 end

function GetInventoryDataReplicationKey(PlayerClass,index)
return readInteger(GetInventoryDataAddress(PlayerClass,index)+0x4);
 end

function GetInventoryDataHandle(PlayerClass,index)
return readInteger(GetInventoryDataAddress(PlayerClass,index)+0xC);
 end

function GetInventoryDataSize(PlayerClass)
return readInteger("[["..PlayerClass.."]+EE0]+230");
 end

 function PrintAllInventoryData(PlayerClass)

local CAP=GetInventoryDataSize(PlayerClass);
if CAP~=nil then
for index=0,CAP,1 do
local X=GetInventoryDataReplicationId(PlayerClass,index) ;
local Handle=GetInventoryDataHandle(PlayerClass,index);
local ReplicationKey=GetInventoryDataReplicationKey(PlayerClass,index);
local Count=readInteger(GetInventoryDataQuanityAddress(PlayerClass,index));

print('['..index..'] '..
NHA_CE.HEX.ConvertFromInt64(GetInventoryDataAddress(PlayerClass,index))..
', Class Id: '..X..
", Quantity: "..Count..
", Handle: "..Handle..
", ReplicationKey: "..ReplicationKey);
end
end
 end


 function GetRainbowGemAddress(PlayerClass)
local n=nil;
local CAP=GetInventoryDataSize(PlayerClass);
if CAP~=nil then
for index=0,CAP,1 do
local X=GetInventoryDataReplicationId(PlayerClass,index) ;
local Handle=GetInventoryDataHandle(PlayerClass,index);
local ReplicationKey=GetInventoryDataReplicationKey(PlayerClass,index);
local Count=readInteger(GetInventoryDataQuanityAddress(PlayerClass,index));

if  X>=4 and X<=50 and  Count<1000000000 and Handle>80 and Handle<2920 and ReplicationKey~=4294967295 and ReplicationKey>=1 then
n=index;
break;
end
end
if n==nil then
return 0x0
else
return NHA_CE.HEX.ConvertFromInt64(GetInventoryDataQuanityAddress(PlayerClass,n));
end
 end
 end


 function GetRainbowGemOffset(PlayerClass)
local n=nil;
local CAP=GetInventoryDataSize(PlayerClass);
if CAP~=nil then
for index=0,CAP,1 do
local X=GetInventoryDataReplicationId(PlayerClass,index) ;
local Handle=GetInventoryDataHandle(PlayerClass,index);
local ReplicationKey=GetInventoryDataReplicationKey(PlayerClass,index);
local Count=readInteger(GetInventoryDataQuanityAddress(PlayerClass,index));
if  X>=4 and X<=50 and  Count<1000000000 and Handle>80 and Handle<2920 and ReplicationKey~=4294967295 and ReplicationKey>=1 then
n=index;
break;
end
end
if n==nil then
return 0x0
else
return  GetInventoryDataIndexId(n)+0x18;
end
 end
end

function SetPlayerRainbowGems(PlayerClass,value)
if GetPlayerCheck() then
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteInteger(GetRainbowGemAddress(PlayerClass),value);
end)
end
end;

function GetPlayerRainbowGems(PlayerClass)
return readInteger(GetRainbowGemAddress(PlayerClass));
end


function MaxPlayerRainbowGems(PlayerClass)
SetPlayerRainbowGems(PlayerClass,Wonderlands.GlobalMaxRainbowGemsInteger);
end

function RemovePlayerRainbowGems(PlayerClass)
SetPlayerRainbowGems(PlayerClass,0);
end







--[[

Godmode Functions
]]
function SetPlayerGodmode(PlayerClass,value)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
if value then
writeByte('[['..PlayerClass..']+EC0]+840',1);
else
writeByte('[['..PlayerClass..']+EC0]+840',0);
end
end)
end

function GetPlayerGodmode(PlayerClass)
return readByte('[['..PlayerClass..']+EC0]+840')~=0;
end

function DisablePlayerGodmode(PlayerClass)
SetPlayerGodmode(PlayerClass,false);
end

function EnablePlayerGodmode(PlayerClass)
SetPlayerGodmode(PlayerClass,true);
end


--[[
	Read / Get The Player Name From The Player Class
]]
function GetPlayerName(PlayerClass)
return ReadString("[["..PlayerClass.."+478]+460]+0",50,true);
end

--[[
    Set Player Walk Speed
]]
function SetMaxWalkSpeed(PlayerClass,value)
WriteFloat("[["..PlayerClass.."]+4C8]+278",value);
end

--[[
    Get Player Walk Speed
]]
function GetMaxWalkSpeed(PlayerClass)
return ReadFloat("[["..PlayerClass.."]+4C8]+278");
end


--[[
    Set Player Crouch Speed
]]
function SetMaxCrouchSpeed(PlayerClass,value)
WriteFloat("[["..PlayerClass.."]+4C8]+284",value);
end

--[[
    Get Player Crouch Speed
]]
function GetMaxCrouchSpeed(PlayerClass)
return ReadFloat("[["..PlayerClass.."]+4C8]+284");
end

--[[
    Set Player Sprint Speed
]]
function SetMaxSprintSpeed(PlayerClass,value)
WriteFloat("[["..PlayerClass.."]+4C8]+2980",value);
end

--[[
    Get Player Sprint Speed
]]
function GetMaxSprintSpeed(PlayerClass)
return ReadFloat("[["..PlayerClass.."]+4C8]+2980");
end


--[[
    Set Player Gravity
]]
function SetGravity(PlayerClass,value)
WriteFloat("[["..PlayerClass.."]+900]+230",value);
end

--[[
    Get Player Gravity
]]
function GetGravity(PlayerClass)
return ReadFloat("[["..PlayerClass.."]+900]+230");
end


--[[
    Set Player Max Jump Count
]]
function SetPlayerMaxJumpCount(PlayerClass,value)
WriteInteger("["..PlayerClass.."]+580",value);
end

--[[
    Get Player Max Jump Count
]]
function GetPlayerMaxJumpCount(PlayerClass)
return ReadInteger("["..PlayerClass.."]+580");
end


function SetPlayerSuperJump(PlayerClass,value)
if value then
SetPlayerMaxJumpCount(PlayerClass,999999)
SetGravity(PlayerClass,0.5);
else
SetPlayerMaxJumpCount(PlayerClass,1)
SetGravity(PlayerClass,1);
end
end

function GetPlayerSuperJump(PlayerClass)
return
GetPlayerMaxJumpCount(PlayerClass)==999999 and
GetGravity(PlayerClass)==0.5
;
end



Wonderlands.GlobalPlayerSuperSpeedModifier=3;
--[[
    Set Player Super Speed
]]
function SetPlayerSuperSpeed(PlayerClass,value)
if value then
SetMaxWalkSpeed(PlayerClass,470*Wonderlands.GlobalPlayerSuperSpeedModifier);
SetMaxCrouchSpeed(PlayerClass,275*Wonderlands.GlobalPlayerSuperSpeedModifier);
SetMaxSprintSpeed(PlayerClass,720*Wonderlands.GlobalPlayerSuperSpeedModifier);
else
SetMaxWalkSpeed(PlayerClass,470);
SetMaxCrouchSpeed(PlayerClass,275);
SetMaxSprintSpeed(PlayerClass,720);
end
end

--[[
    Get Player Super Speed
]]
function GetPlayerSuperSpeed(PlayerClass)
return
GetMaxWalkSpeed(PlayerClass)~=470 and
GetMaxCrouchSpeed(PlayerClass)~=275 and
GetMaxSprintSpeed(PlayerClass)~=720
;
end





--[[
	Get The Players Ability To Fly
]]
function GetPlayerFlyMode(PlayerClass)
return readByte("[["..PlayerClass.."]+4C8]+248")==0x5
end

--[[
	Set The Players Ability To Fly
]]
function SetPlayerFlyMode(PlayerClass,value)
if value then
WriteByte("[["..PlayerClass.."]+4C8]+248",0x5);
else
WriteByte("[["..PlayerClass.."]+4C8]+248",0x3);
end
end


--[[
	Get The Players Noclip Status
]]
function GetPlayerNoclip(PlayerClass)
return readByte("["..PlayerClass.."]+93")==0x1D
end

--[[
	Set The Players Noclip Status
]]
function SetPlayerNoclip(PlayerClass,value)
if value then
WriteByte("["..PlayerClass.."]+93",0x1D);
else
WriteByte("["..PlayerClass.."]+93",0x9D);
end
end

--[[
	Check If The Player Has Full Noclip
]]
function GetFlyAndNoclip(PlayerClass)
return GetPlayerNoclip(PlayerClass) and GetPlayerFlyMode(PlayerClass);
end

--[[
	Enable Full Noclip
]]
function SetFlyAndNoclip(PlayerClass,value)
SetPlayerNoclip(PlayerClass,value);
SetPlayerFlyMode(PlayerClass,value);
end





--[[
	Get The Players No Target
]]
function GetPlayerNoTarget(PlayerClass)
return readByte("[[["..PlayerClass.."]+490]+950]+3B8")==0x1
end

--[[
	Set The Players No Target
]]
function SetPlayerNoTarget(PlayerClass,value)
if value then
WriteByte("[[["..PlayerClass.."]+490]+950]+3B8",0x1);
else
WriteByte("[[["..PlayerClass.."]+490]+950]+3B8",0x0);
end
end

--[[
	Get The Players Visibility
]]
function GetPlayerVisibility(PlayerClass)
return readByte("[[["..PlayerClass.."]+490]+950]+26C")==0x0
end

--[[
	Set The Players Visibility
]]
function SetPlayerVisibility(PlayerClass,value)
if value then
WriteByte("[[["..PlayerClass.."]+490]+950]+26C",0x0);
else
WriteByte("[[["..PlayerClass.."]+490]+950]+26C",0x1);
end
end


--[[
	Teleport One Entity To Another
]]
function TeleportEntityToEntity(Teleporter,Location)
local TargetCoordX =GetEntityPositionX(Location) ;
local TargetCoordY = GetEntityPositionY(Location);
local TargetCoordZ = GetEntityPositionZ(Location);
if Teleporter ~=nil then
SetEntityPositionX(Teleporter,TargetCoordX) -- X Coord
SetEntityPositionY(Teleporter,TargetCoordY) -- Y Coord
SetEntityPositionZ(Teleporter,TargetCoordZ) -- Z Coord
end
end







--[[
Pet Offsets
]]
registerSymbol("Character.PetOwnerComponent","2DC0");
registerSymbol("PetOwnerComponent.PetInfo","1B8");
registerSymbol("PetInfo.ComponentSize",0x158);

--[[
Get The Pet Address Index
]]
function CalculatePetAddress(Index);
return getAddress("PetInfo.ComponentSize")*Index;end

--[[
Get The Pet Info Base Address (Dont Try Writing Over Unless Your A Smart Cunt)
]]
function GetPetInfoBase(PlayerClass,Index)
if readPointer("["..PlayerClass.."]+Character.PetOwnerComponent")~=nil then
if readPointer("[["..PlayerClass.."]+Character.PetOwnerComponent]+PetOwnerComponent.PetInfo")~=nil then
return getAddress("[[["..PlayerClass.."]+Character.PetOwnerComponent]+PetOwnerComponent.PetInfo]+"..
NHA_CE.HEX.ConvertFromInt64( CalculatePetAddress(Index) ));
else
return 0
end
else
return 0
end
end


--[[
Get Pet Active
]]
function GetPetActive(PlayerBase,Index)
return ReadByte(GetPetInfoBase(PlayerBase,Index) )~=0;end
--[[
Set Pet Active
]]
function SetPetActive(PlayerBase,Index,value)
WriteByte(GetPetInfoBase(PlayerBase,Index) ,BoolConverter(value,1,0));end


--[[
Get Player Last Active
]]
function GetPetLastActive(PlayerBase,Index)
return ReadByte(GetPetInfoBase(PlayerBase,Index)+0x1 )~=0;end
--[[
Set Pet Last Active
]]
function SetPetLastActive(PlayerBase,Index,value)
WriteByte(GetPetInfoBase(PlayerBase,Index)+0x1 ,BoolConverter(value,1,0));end


--[[
Get The Pet Class Pointer
]]
function GetPetClass(PlayerBase,Index);
return ReadPointer(GetPetInfoBase(PlayerBase,Index)+0x8 );end
--[[
Set The Pet Class Pointer
]]
function SetPetClass(PlayerBase,Index,value);
WritePointer(GetPetInfoBase(PlayerBase,Index)+0x8 ,value);end;



--[[
Get The Pet (Inner) Current Pet Pointer
]]
function GetPetCurrentPetPointer(PlayerBase,Index);
return ReadPointer(GetPetInfoBase(PlayerBase,Index)+0xE8 );end
--[[
Set The Pet (Inner) Current Pet Pointer
]]
function SetPetCurrentPetPointer(PlayerBase,Index,value);
WritePointer(GetPetInfoBase(PlayerBase,Index)+0xE8 ,value);end;


--[[
Get The Pet Spawn Count
]]
function GetPetSpawnCount(PlayerBase,Index);
return ReadInteger(GetPetInfoBase(PlayerBase,Index)+0xF0 );end
--[[
Set The Pet Spawn Count
]]
function SetPetSpawnCount(PlayerBase,Index,value);
WriteInteger(GetPetInfoBase(PlayerBase,Index)+0xF0 ,value);end;


--[[
Get The Pet Local Spawn Count
]]
function GetPetLocalSpawnCount(PlayerBase,Index);
return ReadInteger(GetPetInfoBase(PlayerBase,Index)+0xF4 );end
--[[
Set The Pet Local Spawn Count
]]
function SetPetLocalSpawnCount(PlayerBase,Index,value);
WriteInteger(GetPetInfoBase(PlayerBase,Index)+0xF4 ,value);end;


--[[
Get DoNotAllowPetSpawning
]]
function GetDoNotAllowPetSpawning(PlayerBase,Index)
return ReadByte(GetPetInfoBase(PlayerBase,Index)+0x110 )~=0;end
--[[
Set DoNotAllowPetSpawning
]]
function SetDoNotAllowPetSpawning(PlayerBase,Index,value)
WriteByte(GetPetInfoBase(PlayerBase,Index)+0x110 ,BoolConverter(value,1,0));end


--[[
    Debug Function For Pet Infomation
]]
function PrintPetInfomation(PlayerBase,Index)
if PlayerBase~=nil then
print("["..NHA_CE.HEX.ConvertFromInt64(GetPetInfoBase(PlayerBase,Index)).."] Pet: "..Index);
print("State: "..BoolConverter(GetPetActive(PlayerBase,Index),"Active","Inactive"));
print("Class: "..NHA_CE.HEX.ConvertFromInt64(GetPetClass(PlayerBase,Index)));
print("Current Pet: "..NHA_CE.HEX.ConvertFromInt64(GetPetCurrentPetPointer(PlayerBase,Index)));
print("Spawn Count: "..GetPetSpawnCount(PlayerBase,Index));
print("Local Spawn Count: "..GetPetLocalSpawnCount(PlayerBase,Index));
print("Spawn Blocked: "..BoolConverter(GetDoNotAllowPetSpawning(PlayerBase,Index),"Yes","No"));

else
print("Player Isnt Spawned!");
end
end

function DuplicatePet(PlayerClass,petindex)
if GetPetActive(PlayerClass,petindex)==false then
SetPetActive(PlayerClass,petindex,true);
end
SetDoNotAllowPetSpawning(PlayerClass,petindex,false);
SetPetCurrentPetPointer(PlayerClass,petindex,0);
--PrintPetInfomation(PlayerClass,petindex)
createThread(function()
sleep(60);
SetDoNotAllowPetSpawning(PlayerClass,petindex,false);
SetPetCurrentPetPointer(PlayerClass,petindex,0);
sleep(700);
SetDoNotAllowPetSpawning(PlayerClass,petindex,true);
end)
end











function GetPlayerSkillTreeIndex(index)
return 0x30*index;
end

function GetPlayerSkillTreeBase(PlayerClass)
if PlayerClass==nil then
return 0;
else
return readPointer("[[["..PlayerClass.."]+PlayerController.PlayerAbilityManagerComponent]+PlayerAbilityManagerComponent.PlayerAbilityTree]+PlayerAbilityTree.Items");
end
end

function GetPlayerSkillTreeItemBase(PlayerClass,index)
if PlayerClass==nil then
return 0;
else
return getAddress( NHA_CE.HEX.ConvertFromInt64(GetPlayerSkillTreeBase(PlayerClass)).."+"..NHA_CE.HEX.ConvertFromInt64(GetPlayerSkillTreeIndex(index)));
end
end

function GetPlayerSkillTreeItemLevel(PlayerClass,index)
if PlayerClass==nil then
return 0;
else
return  readInteger(GetPlayerSkillTreeItemBase(PlayerClass,index)+0x28);
end
end

function GetPlayerSkillTreeItemId(PlayerClass,index)
if PlayerClass==nil then
return 0;
else
return  readInteger(GetPlayerSkillTreeItemBase(PlayerClass,index)+0x10);
end
end

function GetSkillTreeItemData(PlayerClass,index)
return readPointer(GetPlayerSkillTreeItemBase(PlayerClass,index)+0x8);
end

function GetPlayerSkillTreeItemMaxLevel(PlayerClass,index)
if PlayerClass==nil then
return 0;
else
return readInteger(GetSkillTreeItemData(PlayerClass,index)+0x30);
end
end

function SetPlayerSkillTreeItemLevel(PlayerClass,index,Level)
WriteInteger(GetPlayerSkillTreeItemBase(PlayerClass,index)+0x28,Level);
end

function GetPlayerSkillTreeSize(PlayerClass)
if PlayerClass==nil then
return 0;
else
return readInteger("[[["..PlayerClass.."]+PlayerController.PlayerAbilityManagerComponent]+PlayerAbilityManagerComponent.PlayerAbilityTree]+PlayerAbilityTree.Items+8");
end
end

function PrintAllPlayerSkillTreeInfo(PlayerClass)
local Count=GetPlayerSkillTreeSize(PlayerClass);
if Count>0 then
print("Skill Tree Base: "..NHA_CE.HEX.ConvertFromInt64(GetPlayerSkillTreeBase(PlayerClass)));
print("Skill Tree Count: "..Count);
for Index=0,Count-1,1 do
local HEX=NHA_CE.HEX.ConvertFromInt64(GetPlayerSkillTreeIndex(Index));
print("Index/Hex  =  ["..Index.."] / ["..HEX.."],\n"..
"SkillTree.Item.Address: "..NHA_CE.HEX.ConvertFromInt64(GetPlayerSkillTreeItemBase(PlayerClass,Index))..
",\n"..
"SkillTree.Item.Data.Address: "..NHA_CE.HEX.ConvertFromInt64(GetSkillTreeItemData(PlayerClass,Index))..
",\n"..
--"SkillTree.Item.Index: "..GetPlayerSkillTreeItemId(PlayerClass,Index)..",\n"..
"SkillTree.Item.Level: "..GetPlayerSkillTreeItemLevel(PlayerClass,Index).."/"..GetPlayerSkillTreeItemMaxLevel(PlayerClass,Index)..
"\n");
end
else
print("Player Is Not Spawned!");
end
end


function SetAllSkillTreeLevels(PlayerClass,Level)
local Count=GetPlayerSkillTreeSize(PlayerClass);
if Count>0 then
for Index=0,Count-1,1 do
SetPlayerSkillTreeItemLevel(PlayerClass,Index,Level)
end
end
end

function MaxAllSkillTreeLevels(PlayerClass)
local Count=GetPlayerSkillTreeSize(PlayerClass);
if Count>0 then
for Index=0,Count-1,1 do
SetPlayerSkillTreeItemLevel(PlayerClass,Index,GetPlayerSkillTreeItemMaxLevel(PlayerClass,Index))
end
end
end


function SetAllSkillTreeLevelsToMaxMultiplied(PlayerClass,multiplier)
local Count=GetPlayerSkillTreeSize(PlayerClass);
if Count>0 then
if multiplier<1 then;multiplier=1;end
for Index=0,Count-1,1 do
SetPlayerSkillTreeItemLevel(PlayerClass,Index,GetPlayerSkillTreeItemMaxLevel(PlayerClass,Index)*multiplier)
end
end
end

function ResetAllSkillTreeLevels(PlayerClass)
local Count=GetPlayerSkillTreeSize(PlayerClass);
if Count>0 then
for Index=0,Count-1,1 do
SetPlayerSkillTreeItemLevel(PlayerClass,Index,0);
end
end
end

function DebugSkillTrees()
NHA_CE.Hook3r.ClearLogs();
print("NHA's Skill Tree Debugger:");
--ResetAllSkillTreeLevels(GetPlayerX(0))
--SetAllSkillTreeLevelsToMaxMultiplied(GetPlayerX(0),666);
PrintAllPlayerSkillTreeInfo(GetPlayerX(0))
end
