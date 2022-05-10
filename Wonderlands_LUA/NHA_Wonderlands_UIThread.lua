
Wonderlands.UI_ThreadSpeed=200;
Wonderlands.UI_Tick=function();end--Blank UI Function


if Wonderlands.UIThreadFunctionArray~=nil then
for i=#Wonderlands.UIThreadFunctionArray,1,-1 do
Wonderlands.UIThreadFunctionArray[i] = array[#Wonderlands.UIThreadFunctionArray]
Wonderlands.UIThreadFunctionArray[#Wonderlands.UIThreadFunctionArray] = nil
end
end
Wonderlands.UIThreadFunctionArray={};


function Wonderlands.GetIndexInUIThread(actionname)
local Index=0;
local Found=false;
for i,OSX in ipairs(Wonderlands.UIThreadFunctionArray) do
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

function Wonderlands.AddToUITick(actionname,action)
Wonderlands.RemoveFromUITick(actionname);
Wonderlands.UIThreadFunctionArray[#Wonderlands.UIThreadFunctionArray+1]={actionname,action};
end

function Wonderlands.RemoveFromUITick(actionname)
local Found=Wonderlands.GetIndexInUIThread(actionname);
if Found~=nil then
table.remove(Wonderlands.UIThreadFunctionArray,Index)
end;end

function Wonderlands.RunUIThreadFrame()
Wonderlands.UI_Tick();
for i, v in pairs(Wonderlands.UIThreadFunctionArray) do --loop through the table--
v[2]();
end
end


if Wonderlands.UI_Thread~=nil then
Wonderlands.UI_Thread.suspend();
end

 Wonderlands.UI_Thread = createThread(function(timer)
while true do
Wonderlands.RunUIThreadFrame();
     sleep(Wonderlands.UI_ThreadSpeed)
   end
   return 50
 end)
 Wonderlands.UI_Thread.Name="NHA_Wonderlands.UI_Thread";