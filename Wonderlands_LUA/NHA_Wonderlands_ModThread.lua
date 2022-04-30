
Wonderlands.UI_Tick=function();end--Blank UI Function

if Wonderlands.ModTick~=nil then
Wonderlands.ModTick.suspend();
end

 Wonderlands.ModTick = createThread(function(timer)
while true do
TimerTick()
Wonderlands.UI_Tick();
     sleep(250)
   end
   return 50
 end)
 Wonderlands.ModTick.Name="NHA_Wonderlands.ModTick";

if Wonderlands.ModArray~=nil then
for i=#Wonderlands.ModArray,1,-1 do
Wonderlands.ModArray[i] = array[#Wonderlands.ModArray]
Wonderlands.ModArray[#Wonderlands.ModArray] = nil
end
end
Wonderlands.ModArray={};


function Wonderlands.GetIndexInModTick(actionname)
local Index=0;
local Found=false;
for i,OSX in ipairs(Wonderlands.ModArray) do
if OSX[1]==actionname then
Found=true;
break;
else
Index=Index+1;
end
end
if Found then
return Index
end;
return nil;
end

function Wonderlands.AddToModTick(actionname,action)
Wonderlands.RemoveFromModTick(actionname);
Wonderlands.ModArray[#Wonderlands.ModArray+1]={actionname,action};
end

function Wonderlands.RemoveFromModTick(actionname)
local Found=Wonderlands.GetIndexInModTick(actionname);
if Found~=nil then
table.remove(Wonderlands.ModArray,Index)
end;end

function RunModFrame()
for i, v in pairs(Wonderlands.ModArray) do --loop through the table--
v[2]();
end
Wonderlands._LootSploasionFunc();
end

function TimerTick()
if NHA_CE.HOOK~="" then
Wonderlands.IsAttached=getProcessIDFromProcessName(NHA_CE.HOOK)~=nil;
if Wonderlands.IsAttached then

if Wonderlands.IsInGame() then
RunModFrame()
end

else
NHA_CE.HOOK="";
Wonderlands._DONTCALL_AutoDetach();
end;
end
end

