

--[[

Pickup Function Helpers

]]

--Function To Easily Get The String Path To The Player Targeting Actors (Enemy) Array
function PickupArray()
return getAddress("[RefBPGameState_Default_C()+990]");
end

function GetPickup(index)
return getAddress("[RefBPGameState_Default_C()+990]".."+"..List_IndexToHex(index));
end

function PickupArrayCount()
if RefBPGameState_Default_C()~=nil then
return GetAddress("RefBPGameState_Default_C()+998")
end;end

function PickupArrayMax()
return GetAddress("RefBPGameState_Default_C()+99C")
end


function GetCleanupPickupTriggerCount()
return ReadInteger("RefBPGameState_Default_C()+988");
end

function SetCleanupPickupTriggerCount(value)
WriteInteger("RefBPGameState_Default_C()+988",value);
end

function GetCleanupPickupRemainderCount()
return ReadInteger("RefBPGameState_Default_C()+98C");
end

function SetCleanupPickupRemainderCount(value)
WriteInteger("RefBPGameState_Default_C()+98C",value);
end

function PickupCleanupArray()
return NHA_CE.HEX.ConvertFromInt64(ReadPointer("RefBPGameState_Default_C()+9A0"));
end

function SetFirstPickupCleanupObject(ObjectAddress)
WritePointer("[RefBPGameState_Default_C()+9A0]+0",ObjectAddress);
end

function SetPickupCleanupObject(offset,ObjectAddress)
WritePointer("[RefBPGameState_Default_C()+9A0]+"..offset,ObjectAddress);
end

function AddPickupToCleanupArray(offset)
WritePointer("[RefBPGameState_Default_C()+9A0]+"..List_IndexToHex(offset),ReadPointer(GetPickup(offset)));
end


function SetPickupCleanupArrayCount(val)
WriteInteger("RefBPGameState_Default_C()+9A8",val)
end

function GetPickupCleanupArrayCount()
return ReadInteger("RefBPGameState_Default_C()+9A8")
end

function PickupCleanupArrayExists()
local C=ReadInteger("RefBPGameState_Default_C()+9A0");
if C==nil then
return false;
else
return C>0
end
end

Wonderlands.GlobalDeletingAllPickups=false;
Wonderlands.GlobalDeletingAllPickupsSuccess=false;
Wonderlands.GlobalDeletingAllPickupsSeenStartedMessage=false;
Wonderlands.GlobalBackupCleanupTriggerCount=0;
Wonderlands.GlobalBackupCleanupRemainderCount=0;
function DeleteAllPickups()
if Wonderlands.GlobalDeletingAllPickups==false then
Wonderlands.GlobalDeletingAllPickups=true;
Wonderlands.GlobalDeletingAllPickupsSuccess=false;
Wonderlands.GlobalDeletingAllPickupsSeenStartedMessage=false;
Wonderlands.GlobalBackupCleanupTriggerCount=GetCleanupPickupTriggerCount();
Wonderlands.GlobalBackupCleanupRemainderCount=GetCleanupPickupRemainderCount();
if PickupCleanupArrayExists()==false then
print("Cleanup Not Created, Please Drop An Item And Itll Start Deleting!");
end
CreatePickupDeleteTask();
end
end


function CreatePickupDeleteTask()
Wonderlands.AddToModTick("NHA Pickup Deleter",function()
if PickupArray()==nil or PickupCleanupArrayExists()==false then
--?? Turn Me Off Here?
SetCleanupPickupTriggerCount(1);
SetCleanupPickupRemainderCount(1);
else

if Wonderlands.GlobalDeletingAllPickupsSeenStartedMessage==false then
Wonderlands.GlobalDeletingAllPickupsSeenStartedMessage=true;
print("Started Deleting Pickups!");
end
_HandleDeleteAllPickups();

end

end);
end

Wonderlands.GlobalPickupCleanupValue=20;
function _HandleDeleteAllPickups()
local CAP=ReadInteger(PickupArrayCount());
if CAP==0 then
Wonderlands.GlobalDeletingAllPickupsSuccess=true;
StopPickupDeleteTask();
else
local IDX=0;
if CAP>40 then
CAP=40;
end
for ID=0,CAP,1 do
AddPickupToCleanupArray(ID);
IDX=ID;
end
SetPickupCleanupArrayCount(IDX);
end
end


function StopPickupDeleteTask()
if Wonderlands.GlobalDeletingAllPickups then
Wonderlands.GlobalDeletingAllPickups=false;
SetCleanupPickupTriggerCount(Wonderlands.GlobalBackupCleanupTriggerCount);
SetCleanupPickupRemainderCount(Wonderlands.GlobalBackupCleanupRemainderCount);
if Wonderlands.GlobalDeletingAllPickupsSuccess==false then
print("User Forced The Delete Task To End!");
else
print("All Pickups Were Deleted!");
end
Wonderlands.RemoveFromModTick("NHA Pickup Deleter");
end
end

function DeletePickup(PickupClass)
if PickupArray()==nil or PickupCleanupArrayExists()==false then
print("Cant Delete This Pickup As The Cleaner Isnt Yet Created!");
else
SetFirstPickupCleanupObject(ReadPointer(PickupClass));
SetPickupCleanupArrayCount(GetPickupCleanupArrayCount()+1);
end;
end




--Does An Action With Each Enemy
function ForeachPickup(action)
local ID=ReadInteger(PickupArrayCount());
if ID~=nil then
ForeachBuilder(GetPickup,ID-1,function (inputaddress)
if inputaddress~=nil then
local ADDY=NHA_CE.HEX.ConvertFromInt64(ReadPointer(inputaddress));
if ADDY~=nil then
action(inputaddress);
end;
end
end);
end
end

--[[
Pickup Position Functions
]]
function SetPickupPosition(PickupAddress,x,y,z)
if PickupAddress~=nil then
SetPickupPositionX(PickupAddress,x);
SetPickupPositionY(PickupAddress,y);
SetPickupPositionZ(PickupAddress,z);
end
end

function SetPickupLevel(PickupAddress,Level)
WriteInteger('[['..PickupAddress..']+570]+1A8',Level);
end
function GetPickupLevel(PickupAddress)
return ReadInteger('[['..PickupAddress..']+570]+1A8');
end


function SetPickupGameStage(PickupAddress,Level)
WriteInteger('[['..PickupAddress..']+570]+1A4',Level);
end
function GetPickupGameStage(PickupAddress)
return ReadInteger('[['..PickupAddress..']+570]+1A4');
end


function SetPickupMobility(PickupAddress,trueorfalse)
local V=0;
if trueorfalse then
V=2;
end
WriteByte('[['..PickupAddress..']+168]+24E',V);
end
function GetPickupMobility(PickupAddress)
return ReadByte('[['..PickupAddress..']+168]+24E')~=0;
end

function TurnOffPickupMobility(PickupAddress)
SetPickupMobility(PickupAddress,false);
end
function TurnOnPickupMobility(PickupAddress)
SetPickupMobility(PickupAddress,true);
end


function SetPickupExp(PickupAddress,value)
SetPickupLevel(PickupAddress,value);
SetPickupGameStage(PickupAddress,value);
end

function SetPickupExpMax(PickupAddress)
SetPickupExp(PickupAddress,127);
end

Wonderlands.GlobalPickupExpValue=127;

function SetPickupExpFromStored(PickupAddress)
SetPickupExp(PickupAddress,Wonderlands.GlobalPickupExpValue);
end

function PrintAllPickupInfo()
print("All Pickup Info:");
local CDX=0;
function PrintPickupInfo(PickupAddress)
local ADDY=NHA_CE.HEX.ConvertFromInt64(ReadPointer(PickupAddress));
print("["..CDX.."] "..ADDY.." X: "..GetPickupPositionX(PickupAddress)..", Y: "..GetPickupPositionY(PickupAddress)..", Z: "..GetPickupPositionZ(PickupAddress));
CDX=CDX+1;
end
ForeachPickup(PrintPickupInfo);
end



--Set X
function SetPickupPositionX(PlayerClass,x)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteFloat('[['..PlayerClass..']'.."+168"..']+220',x);
end);
end;
--Get X
function GetPickupPositionX(PlayerClass)
return readFloat('[['..PlayerClass..']'.."+168"..']+220');
end
--Set Y
function SetPickupPositionY(PlayerClass,y)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteFloat('[['..PlayerClass..']'.."+168"..']+224',y);
end);
end;
--Get Y
function GetPickupPositionY(PlayerClass)
return readFloat('[['..PlayerClass..']'.."+168"..']+224');
end
--Set Z
function SetPickupPositionZ(PlayerClass,z)
DoIfPlayerIsntNull(PlayerClass,function(_DR_NHA_IS_BOSS)
WriteFloat('[['..PlayerClass..']'.."+168"..']+228',z);
end);
end;
--Get Z
function GetPickupPositionZ(PlayerClass)
return readFloat('[['..PlayerClass..']'.."+168"..']+228');
end
