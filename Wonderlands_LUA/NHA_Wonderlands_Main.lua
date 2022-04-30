--Anything Up Here Should Be Moved To NHA_CE To Keep That Project Full Of Helper Functions!!!
--Check If A File Exists In A Path
function pathExist(pth,fl1);local file=pth..fl1;return os.rename(file, file);end;

function FixSyncIssue(Action,timeout)
if timeout==nil then
timeout=100;
end
 synchronize(function()
   local t = createTimer()
   t.Interval,t.OnTimer = timeout,function(tm)
 tm.Destroy()
Action();
   end
 end)
end



--[[
	Allows Users To Easily Make Their Own Foreach Functions
]]
function ForeachBuilder(ArrayGetFunction,inputsize,action)
for Index=0,inputsize,1 do
local OBJECT=NHA_CE.HEX.ConvertFromInt64(ArrayGetFunction( Index) );
if OBJECT~=nil then
action( OBJECT);
end
end
end






--[[
	NHA Wonderlands (UE) Hook3r Functions
	created by dr NHA For The Public Wonderlands Cheat Table
]]

--[[
	Create The Wonderlands Base Table
]]
Wonderlands={};

--[[
	Lua Var To Hold The Attach State
]]
Wonderlands.IsAttached=false;




function Wonderlands.FixMemoryRecord(description,data)
local NERD=AddressList.getMemoryRecordByDescription(description);
if data~=nil then
data=Wonderlands._T.F.."\n"..table.concat(data, "\n")
else
data=Wonderlands._T.A.."\n"..Wonderlands._T.B.."\n"..Wonderlands._T.C;
end
NERD.DropDownList.Text = data;

NERD.DropDownReadOnly=true;
NERD.DropDownDescriptionOnly=true;
NERD.DisplayAsDropDownListItem=true;
end

function FixMemoryRecord(description,data)
Wonderlands.FixMemoryRecord(description,data);
end

function Wonderlands.FixMemoryRecords(RecordTable,data);
for Index=1,#RecordTable,1 do
Wonderlands.FixMemoryRecord(RecordTable[Index],data)
end
end


--[[
On Auto Detaching
Users Should Not Call This!
]]
function Wonderlands._DONTCALL_AutoDetach()
Wonderlands.IsAttached=false;
print("Auto Detaching From Wonderlands!");
AddressList.getMemoryRecordByDescription("Attach Wonderlands").Active=false;
end


--[[
	Base Table For Contact Information
]]
Wonderlands.TableContact={};
--[[
	Contact Name
]]
Wonderlands.TableContact.OwnerName="dr_NHA";
--[[
	Contact Discord
]]
Wonderlands.TableContact.ContactDiscord="THBpFAxc5x";

--[[
	Print My Ascii To The Lua Console
]]
function NHA_ASCII()
print(--[[PRINT ASCI FOR ATTACH]]
"       __        _   ____  _____       _       __                __          __                __".."\n"..
"  ____/ /____   / | / / / / /   |     | |     / /___  ____  ____/ /__  _____/ /___ _____  ____/ /____".."\n"..
" / __  / ___/  /  |/ / /_/ / /| |     | | /| / / __ \\/ __ \\/ __  / _ \\/ ___/ / __ `/ __ \\/ __  / ___/".."\n"..
"/ /_/ / /     / /|  / __  / ___ |     | |/ |/ / /_/ / / / / /_/ /  __/ /  / / /_/ / / / / /_/ (__  )".."\n"..
"\\__,_/_/     /_/ |_/_/ /_/_/  |_|     |__/|__/\\____/_/ /_/\\__,_/\\___/_/  /_/\\__,_/_/ /_/\\__,_/____/".."\n"..
"\n");
end


--[[
    Handle Scans Completed
]]
function Wonderlands.OnScansCompleted()
Wonderlands.PrintLuaSplit();
if Wonderlands.FailedToAttach==false then
print("\n"..NHA_CE.HOOK.." Attach Successful!");
else
print("\n"..NHA_CE.HOOK.." Attach Un-Successful!!");
end
end

--[[
	Rescanner Settings
]]
Wonderlands.GlobalRescanCount=0;
Wonderlands.GlobalRescanMax=10;



--[[
	Failed To Attach Wonderlands Function
]]
Wonderlands.FailedToAttach=false;
function Wonderlands.FailedAttach(reason)
print(reason);
print("\n");
print("To Report Issues:\n");
print("Please Contact: "..Wonderlands.TableContact.OwnerName.."\n"..
"In The Discord Server: https://discord.gg/"..Wonderlands.TableContact.ContactDiscord);
Wonderlands.FailedToAttach=true;
end

--[[
	Lua Console Line Split Function
]]
Wonderlands.LuaConsoleSplit="\n--**------**---------**---------**--\n";
function Wonderlands.PrintLuaSplit()
print(Wonderlands.LuaConsoleSplit);
end

--[[
	Attach Attempt Function (Includes Auto Running Function)
]]
function Wonderlands.Attach()--Attach Wonderlands
NHA_CE.Hook3r.ClearLogs();--Clear The Lua Engine Logs
NHA_CE.OpenProcess("Wonderlands.exe");--Try To Open Wonderlands Process
NHA_ASCII();
if (NHA_CE.HOOK~="") then--Check If Open Process Worked
Wonderlands.GlobalRescanCount=0;
Wonderlands.FailedToAttach=false;
Wonderlands.PrintLuaSplit();
Wonderlands.FindGEngine();--Get The Game Engine Base
else--Couldnt Open The Process
print("Wonderlands Isnt Launched Yet!");
Wonderlands.OpenGame();--Open Wonderlands
if Wonderlands.LaunchCompleted then
print("Launched Wonderlands For You!");
createNativeThread(function()
sleep(100)--Pre Wait
print("Waiting For Wonderlands To Load!");
sleep(2500)--Wait 2.5 Seconds
NHA_CE.OpenProcess("Wonderlands.exe");--Try To Open Wonderlands Process
if (NHA_CE.HOOK~="") then--Open Process Worked!
--Only Try To Retry Attach After We Check If We Can Connect!
sleep(1000)--Wait 2.5 Seconds
Wonderlands.Attach();
end
end)
else--Launch Couldnt Complete Via CE!
Wonderlands.FailedToAttach=true;
print("Couldn't Auto Launch Wonderlands!!!");
print("The EXE Directory Is Probably Invalid!!!\n".."Directory: "..WonderlandsDirectory);
end;
end
end






--[[
    Instruction Scanner Function
]]
function Wonderlands.InstructionBaseScan(InstructionName,AOB)
if Wonderlands.FailedToAttach==false and NHA_CE.InstructionBaseScan(NHA_CE.HOOK,InstructionName.."::ASM",AOB,false) then;--Found This Instruction
print(InstructionName.."::ASM: "..NHA_CE.HEX.GetAddress(InstructionName.."::ASM"));--Print The True Instruction Base
return true;
elseif Wonderlands.FailedToAttach==false then
return false;
end
end


--[[
	Offset Scanner Function
]]
function Wonderlands.OffsetScanner(InstructionName,AOB,OffsetCluster)
if Wonderlands.FailedToAttach==false and Wonderlands.InstructionBaseScan(InstructionName,AOB) then;--Found This Instruction
for Index=1,#OffsetCluster,1 do
local DB=OffsetCluster[Index];
if DB[3]==true then
RegisterSymbol(DB[1],NHA_CE.ExtractPositiveFromInstructions(getAddress(InstructionName.."::ASM")+DB[2]));
else
RegisterSymbol(DB[1],NHA_CE.ExtractNegativeFromInstructions(getAddress(InstructionName.."::ASM")-DB[2]));
end
print(DB[1]..": ".."+"..NHA_CE.HEX.GetAddress(DB[1]));
end
print(" ");
return true;
else
return false;
end
end




--[[
	Check If A Pointer Path Is Legitimate
]]
function Wonderlands.PointerChecksOut(Path)
local CHQ=ReadPointer(Path);
if CHQ~=nil then
return CHQ>1;
else
return false;
end
end

--[[
	Check If The Local User Is In Game
]]
function Wonderlands.IsInGame()
if NHA_CE.HOOK~="" then
return Wonderlands.PointerChecksOut("[[[GEngine]+GameEngine.GameViewport]+GameViewport.World]");
end
return false;
end



--[[
	Get An Index Of A Pointerlist
]]
function List_IndexToHex(index)
if index==0 then
return "0";
else
return NHA_CE.HEX.ConvertFromInt64(8*index);
end;end


--[[
	Get The Gamestate From The GameViewport.World
]]
function RefBPGameState_Default_C()
if Wonderlands.IsInGame() then
return GetAddress("[[[[GEngine]+GameEngine.GameViewport]+GameViewport.World]+World.BPGameState_Default_C]")
else
return 0;
end
end



