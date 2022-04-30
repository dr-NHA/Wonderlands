
--[[

Enemy Function Helpers

]]

--Function To Easily Get The String Path To The Player Targeting Actors (Enemy) Array
function EnemyArray()
return getAddress("[RefBPGameState_Default_C()+748]");
end

function GetEnemy(index)
return getAddress("[RefBPGameState_Default_C()+748]".."+"..List_IndexToHex(index));
end

function EnemyArrayCount()
if RefBPGameState_Default_C()~=nil then
return GetAddress("RefBPGameState_Default_C()+750")
end;end

function EnemyArrayMax()
return GetAddress("RefBPGameState_Default_C()+754")
end

--Does An Action With Each Enemy
function ForeachEnemy(action)
ForeachBuilder(GetEnemy,ReadInteger(EnemyArrayCount())-1,function (inputaddress)
if inputaddress~=nil then
local ADDY=NHA_CE.HEX.ConvertFromInt64(ReadPointer(inputaddress));
local SH=GetPlayerShield(inputaddress);
local HP=GetPlayerHealth(inputaddress);
if IsPlayer(inputaddress)==false and Is_AI(inputaddress) then;
if SH~=nil and HP~=nil then
action(inputaddress);
end;end
end
end);
end