


--[[

PlayerTargetables Function Helpers

]]

--Function To Easily Get The String Path To The Player Targeting Actors (Enemy) Array
function PlayerTargetablesArray()
return getAddress("[[[GEngine]+11F8]+BD0]");
end

function GetPlayerTargetable(index)
return readPointer("[[[GEngine]+11F8]+BD0]".."+"..List_IndexToHex(index));
end


function GetPlayerTargetableByOffset(OFFSET)
return readPointer("[[[GEngine]+11F8]+BD0]".."+"..OFFSET);
end

function PlayerTargetablesArrayCount()
if RefBPGameState_Default_C()~=nil then
return GetAddress("[[GEngine]+11F8]+BD8")
end;end

function PlayerTargetablesArrayMax()
return GetAddress("[[GEngine]+11F8]+BDC")
end

function GetCurrentPlayerTargetablesArrayCount()
local D=ReadInteger(PlayerTargetablesArrayCount());
if D==nil then
return 0;
else
return (D-1)*2;
end
end


--Does An Action With Each Player Targetable
function ForeachPlayerTargetable(action)
local Index=0;
ForeachBuilder(GetPlayerTargetable,GetCurrentPlayerTargetablesArrayCount(),function(inputaddress)
if inputaddress~=nil and Index==0 then
action(inputaddress);
Index=Index+1;
elseif Index==1 then
Index=0;
end
end);
end


--Does An Action With Each Player Targetable
function Foreach_NonPlayer_PlayerTargetable(action)
local Index=0;
ForeachBuilder(GetPlayerTargetable,GetCurrentPlayerTargetablesArrayCount(),function(inputaddress)
if inputaddress~=nil and Index==0 then
if Entity.IsPlayer(inputaddress)==false then
action(inputaddress);end
Index=Index+1;
elseif Index==1 then
Index=0;
end
end);
end

--Does An Action With Each Player Targetable
function Foreach_NonPlayerAlly_PlayerTargetable(action)
local Index=0;
ForeachBuilder(GetPlayerTargetable,GetCurrentPlayerTargetablesArrayCount(),function(inputaddress)
if inputaddress~=nil and Index==0 then
if Entity.Is_AI(inputaddress) and Entity.IsAllyTeam(inputaddress) then
action(inputaddress);end
Index=Index+1;
elseif Index==1 then
Index=0;
end
end);
end


--Does An Action With Each Player Targetable
function Foreach_IsAI_PlayerTargetable(action)
local Index=0;
ForeachBuilder(GetPlayerTargetable,GetCurrentPlayerTargetablesArrayCount(),function(inputaddress)
if inputaddress~=nil and Index==0 then
if Entity.Is_AI(inputaddress) then
action(inputaddress);end
Index=Index+1;
elseif Index==1 then
Index=0;
end
end);
end

--Does An Action With Each Player Targetable
function Foreach_Enemy_PlayerTargetable(action)
local Index=0;
ForeachBuilder(GetPlayerTargetable,GetCurrentPlayerTargetablesArrayCount(),function(inputaddress)
if inputaddress~=nil and Index==0 then
if Entity.Is_AI(inputaddress) and Entity.IsEnemyTeam(inputaddress) then
action(inputaddress);end
Index=Index+1;
elseif Index==1 then
Index=0;
end
end);
end

--Does An Action With Each Player Targetable
function Foreach_Unknown_PlayerTargetable(action)
local Index=0;
ForeachBuilder(GetPlayerTargetable,GetCurrentPlayerTargetablesArrayCount(),function(inputaddress)
if inputaddress~=nil and Index==0 then
if Entity.IsUnknownEntity(PlayerClass) then;action(inputaddress);end
Index=Index+1;
elseif Index==1 then
Index=0;
end
end);
end

function PrintAllTargetableInfo()
if ReadInteger(PlayerTargetablesArrayCount())~=0 then
print("\nPlayer Targetables Info:");
ForeachPlayerTargetable(PrintEntityInfo);
else
print("No Targetables In Array!");
end
end


function Print_Enemies_Info()
if ReadInteger(PlayerTargetablesArrayCount())~=0 then
print("\nPlayer Enemies Info:");
Foreach_Enemy_PlayerTargetable(PrintEntityInfo);
else
print("No Enemies In Array!");
end
end


local CDX=0;
function PrintEntityInfo(inputaddress)
local ADDY=NHA_CE.HEX.ConvertFromInt64(GetAddress(inputaddress));

if ADDY==nil then
else
local Class=NHA_CE.HEX.ConvertFromInt64(Entity.Class(ADDY));
local SH=Entity.Shield.CurrentValue.Get(ADDY);
local HP=Entity.Health.CurrentValue.Get(ADDY);
local XObjectType="Unknown";
if Entity.IsPlayer(ADDY) then;
XObjectType="Player";
elseif Entity.Is_AI(ADDY) then
XObjectType="AI/NPC";
end
if SH==nil then;SH="0";end
if HP==nil then;HP="0";end


local X=Entity.Position.X.Get(ADDY);
local Y=Entity.Position.Y.Get(ADDY);
local Z=Entity.Position.Z.Get(ADDY);

local TEAM=Entity.GetTeamName(ADDY);
if TEAM==nil then
TEAM="None";
end

local LVL=GetAIExperienceLevel(ADDY);
if LVL==nil then
LVL="?";
end

local GS=GetAIGameStage(ADDY)
if GS==nil then
GS="?";
end

local MainDeathStatName=Entity.MainDeathStatName(ADDY);
if MainDeathStatName~=nil then
MainDeathStatName=", MainDeathStatName: "..Entity.MainDeathStatName(ADDY);
else
MainDeathStatName=" ";
end


print("Targetable, Index: "..CDX..
", Address: "..ADDY..
", Class: "..Class..
MainDeathStatName..
", Health: "..HP..
", Shield: "..SH..
", ObjectType: "..XObjectType..
", TeamName: "..TEAM..
", LVL: "..LVL..
", AIGameStage: "..GS..
", Position: X:"..X..", Y:"..Y..", Z:"..Z..",");
CDX=CDX+1;
end

end
