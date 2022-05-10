RegisterSymbol("Controller.AutoPossessAI","469");
RegisterSymbol("Controller.TargetableComponent","908");
RegisterSymbol("GameObject.TargetableComponent","5D0");
RegisterSymbol("GameObject.CachedTargetableComponent","4F8");
RegisterSymbol("Crystal.TargetableComponent","668");
RegisterSymbol("TargetableComponent.Team","180");
RegisterSymbol("Team.DisplayName","30");
RegisterSymbol("Controller.CachedFoleyMainComponent","D38")
RegisterSymbol("Class.Class","10")

NHA_CE.ReadString=function(Address,Silent)
if Address==nil then;return nil;end
if Silent==nil then
Silent=false;
end
Address=NHA_CE.HEX.ConvertFromInt64(Address);
local READ=ReadString("["..Address.."+28]",300,true);
if READ==nil then
if Silent=="" then;return nil;end
if Silent==false then
return "Issue Reading String From: "..Address;
else
return Silent;
end
end
return READ;
end

Entity={};
Entity.AutoPossessAI=function(ControllerClass);return readByte(ControllerClass..'+Controller.AutoPossessAI');end;
Entity.GlobalAnimationSpeed=PATH_GetSetFloat(function(EntityAddress);return '['..EntityAddress..'+4C0]+B30';end);
Entity.CachedFoleyMainComponent=function(ControllerClass);return readPointer(ControllerClass..'+Controller.CachedFoleyMainComponent')>1;end;
Entity.Class=function(ControllerClass);return readPointer(ControllerClass..'+Class.Class');end;
Entity.OakDamageComponent=function(ControllerClass);return readPointer(ControllerClass..'+EC0');end;
Entity.DeathData=function(ControllerClass);return readPointer(NHA_CE.HEX.ConvertFromInt64(Entity.OakDamageComponent(ControllerClass))..'+668');end;
Entity.MainDeathStatName=function(ControllerClass);
if Entity.DeathData(ControllerClass)==nil then
return nil;
end
if Entity.DeathData(ControllerClass)<1 then
return nil;
end
return NHA_CE.ReadString(getAddress("[[[[["..NHA_CE.HEX.ConvertFromInt64(ControllerClass)..'+EC0]+668]+30]+0]+48]'),true);end;

Entity.MainDeathStatName2=function(ControllerClass);
if Entity.DeathData(ControllerClass)<1 then
return nil;
end
return NHA_CE.ReadString(getAddress("[[[[["..NHA_CE.HEX.ConvertFromInt64(ControllerClass)..'+EC0]+668]+30]+8]+48]'),true);end;

Entity.DeathStatNameCount=function(ControllerClass);
return readInteger("[["..NHA_CE.HEX.ConvertFromInt64(ControllerClass)..'+EC0]+668]+38');end;

Entity.IsBoss=function(ControllerClass)
local C= Entity.DeathStatNameCount(ControllerClass);
if C==nil then;C=0;end;
if C>0 then
local MDSN=Entity.MainDeathStatName(ControllerClass);
if MDSN==nil then; MDSN="";end
if MDSN=="Dragon Lord kills" or MDSN=="Colossus kills" then
return true;
end
if C>1 then
MDSN=Entity.MainDeathStatName2(ControllerClass);
if MDSN==nil then; MDSN="";end
if MDSN=="Dragon Lord kills" or MDSN=="Colossus kills" then
return true;
end
end
end
return false;
end

Entity.TeamNameAddress=function(EntityAddress)
if Entity.IsUnknownEntity(EntityAddress) then
local ADDRESS=readPointer('[['..EntityAddress..'+GameObject.TargetableComponent]+TargetableComponent.Team]+Team.DisplayName');
local ADDRESS2=readPointer('[['..EntityAddress..'+GameObject.CachedTargetableComponent]+TargetableComponent.Team]+Team.DisplayName');
if readString(ADDRESS,32,true)~=nil then
return ADDRESS;
elseif readString(ADDRESS2,32,true)~=nil then
return ADDRESS2;
else
ADDRESS=readPointer('[['..EntityAddress..'+Crystal.TargetableComponent]+TargetableComponent.Team]+Team.DisplayName');
return ADDRESS;
end
end
return readPointer('[['..EntityAddress..'+Controller.TargetableComponent]+TargetableComponent.Team]+Team.DisplayName');
end;
Entity.GetTeamName=function(EntityAddress);
local NAME=readString(Entity.TeamNameAddress(EntityAddress),32,true);
if NAME==nil then
NAME="No Name Assigned!";
end
return NAME;end;

Entity.IsPlayer=function(EntityAddress)
if EntityAddress==nil then;return false;
else;return readPointer(EntityAddress.."+9C0")~=0 and Entity.AutoPossessAI(EntityAddress)==0;
end;end


Entity.Is_AI=function(EntityAddress)
if EntityAddress==nil then;return false;
else;return readPointer(EntityAddress.."+9C0")==0 and ( Entity.AutoPossessAI(EntityAddress)>0 and Entity.AutoPossessAI(EntityAddress)<5 );
end;end

Entity.IsUnknownEntity=function(EntityAddress)
if EntityAddress==nil then;return false;
else;return Entity.Is_AI(EntityAddress)==false and  Entity.IsPlayer(EntityAddress)==false
end;end


Entity.IsAllyTeam=function(EntityAddress);local STER=Entity.GetTeamName(EntityAddress);
return STER=="Players" or STER=="NonPlayers" or TEM=="Friendly to All";
end

Entity.IsEnemyTeam=function(EntityAddress);local STER=Entity.GetTeamName(EntityAddress);
return NHA_CE.String.StartsWith(STER, "Team_") or STER=="PlayerHaters" or STER=="Enemies" --or STER=="Destroy Me";
end

Entity.IfIsPlayer=function(EntityAddress,false_object,true_object)
if Entity.IsPlayer(EntityAddress) then;return true_object;
else;return false_object;
end;end

Entity.IfIsUnknownEntity=function(EntityAddress,false_object,true_object)
if Entity.IsUnknownEntity(EntityAddress) then;return true_object;
else;return false_object;
end;end

ResourcePool={
};
ResourcePool.PoolSize= 0xF8;
function ResourcePool.GetResourcePool(index);return NHA_CE.HEX.ConvertFromInt64(
ResourcePool.PoolSize*index
);end
ResourcePool.MinValue="00000014"--"Float"
ResourcePool.MaxValue="00000020"--"Float"
ResourcePool.PercentOfMaxValueReserved="0000002C"--"Float"
ResourcePool.ConsumptionRate="00000038"--"Float"
ResourcePool.ActiveRegenerationRate="00000044"--"Float"
ResourcePool.OnIdleRegenerationRate="00000050"--"Float"
ResourcePool.OnIdleRegenerationDelay="0000005C"--"Float"
ResourcePool.OnDepletedIdleRegenerationDelay="00000068"--"Float"
ResourcePool.PassiveRegenerationRate="00000074"--"Float"
ResourcePool.PassivePercentRegenerationRate="00000080"--"Float"
ResourcePool.PassiveMissingPercentRegenerationRate="0000008C"--"Float"
ResourcePool.RegenerationDisabled="00000098"--"4 Bytes"
ResourcePool.CurrentValue="000000A0"--"Float"
ResourcePool.LastEffectiveMaxValue="000000AC"--"Float"
ResourcePool.PostAddedRegenerationRate="000000B4"--"Float"
ResourcePool.PostAddedPercentRegenerationRate="000000C0"--"Float"


ResourcePool.PATH_NewPoolView=function(isplayeroffset)
local NHA_={
Offset=function(EntityAddress);return Entity.IfIsPlayer(EntityAddress,ResourcePool.GetResourcePool(isplayeroffset-1),ResourcePool.GetResourcePool(isplayeroffset));end,
};
NHA_.Address=function(EntityAddress);return '[['..EntityAddress..'+EB8]+180]+'..NHA_.Offset(EntityAddress);end;
NHA_.GetFromAddress=function(EntityAddress,Pool);return NHA_.Address(EntityAddress).."+"..Pool;end;

NHA_.MinValue=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.MinValue);end);
NHA_.CurrentValue=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.CurrentValue);end);
NHA_.MaxValue=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.MaxValue);end);
NHA_.PercentOfMaxValueReserved=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.PercentOfMaxValueReserved);end);
NHA_.ConsumptionRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.ConsumptionRate);end);
--REGEN
NHA_.ActiveRegenerationRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.ActiveRegenerationRate);end);
NHA_.PassiveRegenerationRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.PassiveRegenerationRate);end);
NHA_.PassivePercentRegenerationRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.PassivePercentRegenerationRate);end);
NHA_.PassiveMissingPercentRegenerationRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.PassiveMissingPercentRegenerationRate);end);
NHA_.OnIdleRegenerationRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.OnIdleRegenerationRate);end);
NHA_.OnIdleRegenerationDelay=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.OnIdleRegenerationDelay);end);
NHA_.OnDepletedIdleRegenerationDelay=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.OnDepletedIdleRegenerationDelay);end);
NHA_.PostAddedRegenerationRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.PostAddedRegenerationRate);end);
NHA_.PostAddedPercentRegenerationRate=PATH_GetSetFloat(function(EntityAddress);return NHA_.GetFromAddress(EntityAddress,ResourcePool.PostAddedPercentRegenerationRate);end);

--Fill The Entitys Health
NHA_.ClearRegen=function(EntityAddress)
NHA_.ActiveRegenerationRate.Set(EntityAddress,0);
NHA_.PassiveRegenerationRate.Set(EntityAddress,0);
NHA_.OnIdleRegenerationRate.Set(EntityAddress,0);
NHA_.PostAddedRegenerationRate.Set(EntityAddress,0);
NHA_.ConsumptionRate.Set(EntityAddress,0);
end;

--Fill The Entitys Health
NHA_.Fill=function(EntityAddress)
NHA_.ClearRegen(EntityAddress);
NHA_.CurrentValue.Set(EntityAddress, NHA_.MaxValue.Get(EntityAddress) );
end;

--Deplete The Entitys Health
NHA_.Deplete=function(EntityAddress,Rate)
local NRate=0-Rate;
NHA_.ActiveRegenerationRate.Set(EntityAddress,NRate);
NHA_.PassiveRegenerationRate.Set(EntityAddress,NRate);
NHA_.OnIdleRegenerationRate.Set(EntityAddress,NRate);
NHA_.PostAddedRegenerationRate.Set(EntityAddress,NRate);
NHA_.ConsumptionRate.Set(EntityAddress,Rate);
end;

NHA_.InstantDeplete=function(EntityAddress)
NHA_.Deplete(EntityAddress,NHA_.MaxValue.Get(EntityAddress)*32);
end
return NHA_;
end



ResourcePool.FNewPoolView=function(GetAddress,isplayeroffset)
local NHA_={
Offset=function();return Entity.IfIsPlayer(GetAddress(),ResourcePool.GetResourcePool(isplayeroffset-1),ResourcePool.GetResourcePool(isplayeroffset));end,
};
NHA_.Address=function();return '[['..GetAddress()..'+EB8]+180]+'..NHA_.Offset();end;
NHA_.GetFromAddress=function(Pool);return NHA_.Address().."+"..Pool;end;

NHA_.MinValue=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.MinValue);end);
NHA_.CurrentValue=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.CurrentValue);end);
NHA_.MaxValue=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.MaxValue);end);
NHA_.PercentOfMaxValueReserved=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.PercentOfMaxValueReserved);end);
NHA_.ConsumptionRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.ConsumptionRate);end);
--REGEN
NHA_.ActiveRegenerationRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.ActiveRegenerationRate);end);
NHA_.PassiveRegenerationRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.PassiveRegenerationRate);end);
NHA_.PassivePercentRegenerationRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.PassivePercentRegenerationRate);end);
NHA_.PassiveMissingPercentRegenerationRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.PassiveMissingPercentRegenerationRate);end);
NHA_.OnIdleRegenerationRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.OnIdleRegenerationRate);end);
NHA_.OnIdleRegenerationDelay=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.OnIdleRegenerationDelay);end);
NHA_.OnDepletedIdleRegenerationDelay=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.OnDepletedIdleRegenerationDelay);end);
NHA_.PostAddedRegenerationRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.PostAddedRegenerationRate);end);
NHA_.PostAddedPercentRegenerationRate=FGetSetFloat(function();return NHA_.GetFromAddress(ResourcePool.PostAddedPercentRegenerationRate);end);

--Fill The Entitys Health
NHA_.ClearRegen=function()
NHA_.ActiveRegenerationRate.Set(0);
NHA_.PassiveRegenerationRate.Set(0);
NHA_.OnIdleRegenerationRate.Set(0);
NHA_.PostAddedRegenerationRate.Set(0);
NHA_.ConsumptionRate.Set(0);
end;

--Fill The Entitys Health
NHA_.Fill=function()
NHA_.ClearRegen();
NHA_.CurrentValue.Set(NHA_.MaxValue.Get() );
end;

--Deplete The Entitys Health
NHA_.Deplete=function(Rate)
local NRate=0-Rate;
NHA_.ActiveRegenerationRate.Set(NRate);
NHA_.PassiveRegenerationRate.Set(NRate);
NHA_.OnIdleRegenerationRate.Set(NRate);
NHA_.PostAddedRegenerationRate.Set(NRate);
NHA_.ConsumptionRate.Set(Rate);
end;

NHA_.InstantDeplete=function()
NHA_.Deplete(NHA_.MaxValue.Get()*32);
end
return NHA_;
end


Entity.Health=ResourcePool.PATH_NewPoolView(1);
Entity.Shield=ResourcePool.PATH_NewPoolView(2);

ResourcePool.Foreach_EntityResourcePool=function(entityfunction)
entityfunction(Entity.Health);
entityfunction(Entity.Shield);
end

--[[
REDACTED
NO COMMENT!
]]
Entity.ForceKill=function(EntityAddress)
if Entity.IsBoss(EntityAddress)==false then
ResourcePool.Foreach_EntityResourcePool(function(Pool)
Pool.InstantDeplete(EntityAddress);
end);end
end
Entity.StopForceKill=function(EntityAddress)
if Entity.IsBoss(EntityAddress)==false then
ResourcePool.Foreach_EntityResourcePool(function(Pool)
Pool.Fill(EntityAddress);
end);end
end




--[[
Position Functions
]]

Entity.PositionOffset=function(EntityAddress);
return Entity.IfIsUnknownEntity(EntityAddress,Entity.IfIsPlayer(EntityAddress,"+4D0","+168"),"+168");end


Entity.Position=PATH_GetSetVector3(function(EntityAddress);
return '['..EntityAddress..Entity.PositionOffset(EntityAddress)..']+220';
end);

Entity.MAIN_TP_Position={
HasBeenSet=false,
X=0,
Y=0,
Z=0,
Set=function(X,Y,Z)
Entity.MAIN_TP_Position.X=X;
Entity.MAIN_TP_Position.Y=Y;
Entity.MAIN_TP_Position.Z=Z;
Entity.MAIN_TP_Position.HasBeenSet=true;
end,
SetFromHost=function()
Entity.MAIN_TP_Position.Set(Players.Host.Position.X.Get(),Players.Host.Position.Y.Get(),Players.Host.Position.Z.Get());
end,
TeleportTo=function(EntityAddress)
Entity.Position.X.Set(EntityAddress,Entity.MAIN_TP_Position.X);
Entity.Position.Y.Set(EntityAddress,Entity.MAIN_TP_Position.Y);
Entity.Position.Z.Set(EntityAddress,Entity.MAIN_TP_Position.Z);
end
};


Entity.TeleportToEntity=function(TeleporterEntity,DestinationEntity)
Entity.Position.X.Set(TeleporterEntity,Entity.Position.X.Get(DestinationEntity));
Entity.Position.Y.Set(TeleporterEntity,Entity.Position.Y.Get(DestinationEntity));
Entity.Position.Z.Set(TeleporterEntity,Entity.Position.Z.Get(DestinationEntity));
end

Entity.TeleportToPlayer=function(TeleporterEntity,DestinationEntity)
Entity.Position.X.Set(TeleporterEntity,Entity.Position.X.Get(DestinationEntity));
Entity.Position.Y.Set(TeleporterEntity,Entity.Position.Y.Get(DestinationEntity));
Entity.Position.Z.Set(TeleporterEntity,Entity.Position.Z.Get(DestinationEntity));
end