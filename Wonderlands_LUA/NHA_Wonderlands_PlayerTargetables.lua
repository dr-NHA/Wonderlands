


--[[

PlayerTargetables Function Helpers

]]

--Function To Easily Get The String Path To The Player Targeting Actors (Enemy) Array
function PlayerTargetablesArray()
return getAddress("[[[GEngine]+11F8]+BD0]");
end

function GetPlayerTargetable(index)
return getAddress("[[[GEngine]+11F8]+BD0]".."+"..List_IndexToHex(index));
end


function GetPlayerTargetableByOffset(OFFSET)
return getAddress("[[[GEngine]+11F8]+BD0]".."+"..OFFSET);
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
if IsPlayer(inputaddress)==false then
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
if Is_AI(inputaddress) and IsAllyTeam(inputaddress) then
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
if Is_AI(inputaddress) then
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
if Is_AI(inputaddress) and IsEnemyTeam(inputaddress) then
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
if IsUnknownEntity(PlayerClass) then;action(inputaddress);end
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

local ADDY=NHA_CE.HEX.ConvertFromInt64(ReadPointer(inputaddress));
if ADDY==nil then
else
local SH=GetPlayerShield(inputaddress);
local HP=GetPlayerHealth(inputaddress);
local XObjectType="Unknown";
if IsPlayer(inputaddress) then;
XObjectType="Player";
elseif Is_AI(inputaddress) then
XObjectType="AI/NPC";
end
if SH==nil then;SH="0";end
if HP==nil then;HP="0";end


local X=GetEntityPositionX(inputaddress);
local Y=GetEntityPositionY(inputaddress);
local Z=GetEntityPositionZ(inputaddress);

local TEAM=GetPlayerTeamName(inputaddress);
if TEAM==nil then
TEAM="None";
end

local LVL=GetAIExperienceLevel(inputaddress);
if LVL==nil then
LVL="?";
end

local GS=GetAIGameStage(inputaddress)
if GS==nil then
GS="?";
end


print("Targetable, Index: "..CDX..
", Address: "..ADDY..
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
