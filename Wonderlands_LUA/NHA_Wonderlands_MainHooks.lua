function Wonderlands.ReAttach()
if (NHA_CE.HOOK=="") then
NHA_CE.OpenProcess("Wonderlands.exe");--Try To Open Wonderlands Process
end
if (NHA_CE.HOOK~="") then
NHA_CE.Hook3r.ClearLogs();
NHA_ASCII();
Wonderlands.PrintLuaSplit();
Wonderlands.FindGEngine();
end
end

function Wonderlands.FindGEngine()
local InstructionName="GEngine";
if Wonderlands.GlobalRescanCount<Wonderlands.GlobalRescanMax then
Wonderlands.GlobalRescanCount=Wonderlands.GlobalRescanCount+1;
if Wonderlands.InstructionBaseScan(InstructionName,
"48 8B 0D ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 8D 4D 80 FF 15 ?? ?? ?? ?? 0F 57 C0 48 8D 4D 88") then;--Found This Instruction
Wonderlands.RefreshGEngineCbuff();
Wonderlands.FindGameVersion();--Get The Game Version
else
createNativeThread(function()
sleep(1000)--Wait A Second Before Starting A Rescan
Wonderlands.FindGEngine();
end)
end
end;
end;

function Wonderlands.RefreshGEngineCbuff()
local InstructionName="GEngine";
NHA_CE.ASM_CBUFF(InstructionName,0,3,7,false);
RegisterSymbol(InstructionName,GetAddress(InstructionName.."::BASE"));--Grab Static Base Address
print("GEngine"..": "..NHA_CE.HEX.GetAddress(InstructionName));
print("\n");
end

function Wonderlands.FindGameVersion()
if Wonderlands.GlobalRescanCount<Wonderlands.GlobalRescanMax then
Wonderlands.GlobalRescanCount=Wonderlands.GlobalRescanCount+1;
if Wonderlands.InstructionBaseScan(--[[Instruction Name]] "GameVersion",
--[[AOB]] "54 69 6E 79 20 54 69 6E 61 27 73 20 57 6F 6E 64 65 72 6C 61 6E 64 73 5F") then;--Found This Instruction
print("GameVersion: "..NHA_CE.HEX.GetAddress("GameVersion::ASM"));
print("\n");
Wonderlands.FindOffsets();--Get Offsets After Game Version Is Found!
else
createNativeThread(function()
sleep(1000)--Wait A Second Before Starting A Rescan
Wonderlands.FindGameVersion();
end)
end
end;
end
