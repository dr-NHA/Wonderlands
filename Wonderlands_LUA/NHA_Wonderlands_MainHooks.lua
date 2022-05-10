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
Wonderlands.Find_DISCORD_DATA()
Wonderlands.FindUserNameVisual();
Wonderlands.FindCannotPlayOnline();
Wonderlands.FindMOTD();
Wonderlands.OnGameExitToMainMenu_Injection();
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
print(InstructionName..": "..NHA_CE.HEX.GetAddress(InstructionName));
print("\n");
end




function Wonderlands.FindUserNameVisual()
local InstructionName="UserNameVisual";
if Wonderlands.GlobalRescanCount<Wonderlands.GlobalRescanMax then
Wonderlands.GlobalRescanCount=Wonderlands.GlobalRescanCount+1;
if Wonderlands.InstructionBaseScan(InstructionName,
"48 8D 0D ?? ?? ?? ?? E8 ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 85 C0 74 ?? E8 ?? ?? ?? ?? 48 8B C8") then;--Found This Instruction
NHA_CE.ASM_CBUFF(InstructionName,0,3,7,false);
RegisterSymbol(InstructionName,GetAddress(InstructionName.."::BASE"));--Grab Static Base Address
print(InstructionName..": "..NHA_CE.HEX.GetAddress(InstructionName));
print("\n");
else
createNativeThread(function()
sleep(1000)--Wait A Second Before Starting A Rescan
Wonderlands.FindUserNameVisual();
end)
end
end;
end;

--[[
48 8D 0D ?? ?? ?? ?? E8 ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 85 C0 74 ?? E8 ?? ?? ?? ?? 48 8B C8
Wonderlands.exe.tls+16D2924 - 48 8D 0D 951AA404     - lea rcx,[Wonderlands.exe.impdata+2C53C0] { (8A41CB80) }
Wonderlands.exe.tls+16D292B - E8 9024D9FE           - call Wonderlands.AK::MemoryMgr::GetPoolName+4810
Wonderlands.exe.tls+16D2930 - E8 FB4DFDFF           - call Wonderlands.exe.tls+16A7730
Wonderlands.exe.tls+16D2935 - 48 85 C0              - test rax,rax
Wonderlands.exe.tls+16D2938 - 74 0E                 - je Wonderlands.exe.tls+16D2948
Wonderlands.exe.tls+16D293A - E8 F14DFDFF           - call Wonderlands.exe.tls+16A7730
Wonderlands.exe.tls+16D293F - 48 8B C8              - mov rcx,rax
Wonderlands.exe.tls+16D2942 - 48 8B 10              - mov rdx,[rax]
Wonderlands.exe.tls+16D2945 - FF 52 18              - call qword ptr [rdx+18]
]]

--[[]]

function AS_CBUFF(InstructionName,ADDRESS,offset0,offset1,offset2)
RegisterSymbol(ADDRESS.."::ASM",GetAddress(InstructionName.."::ASM")+offset0);
NHA_CE.ASM_CBUFF(ADDRESS,0,offset1,offset2,false);
RegisterSymbol(ADDRESS,GetAddress(ADDRESS.."::BASE"));--Grab Static Base Address
print(ADDRESS..": "..NHA_CE.HEX.GetAddress(ADDRESS)..", ASM: "..NHA_CE.HEX.GetAddress(ADDRESS.."::ASM"));
end

 function WriteStringProtected(Address,String,Widestring)
print("Overide Protection:");
print(Address);
print("Size:");
 local CAP=#String*2+1;
print(CAP);
 fullAccess(Address,CAP);
writeString(Address,String, Widestring);
writeByte(getAddress(Address)+CAP-1,0);
writeByte(getAddress(Address)+CAP,0);
end

function Wonderlands.FindCannotPlayOnline()
local InstructionName="CannotPlayOnline";

if Wonderlands.GlobalRescanCount<Wonderlands.GlobalRescanMax then
Wonderlands.GlobalRescanCount=Wonderlands.GlobalRescanCount+1;
if Wonderlands.InstructionBaseScan(InstructionName,
"75 ?? 48 8B 03 BA ?? ?? ?? ?? 48 8B CB FF 50 ?? 4C 8D 0D ?? ?? ?? ?? 4C 8D 05 ?? ?? ?? ?? 48 8D 15 ?? ?? ?? ?? 48 8D 4D ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4C 24 68 E8 ?? ?? ?? ?? 48 8B") then;--Found This Instruction

print("\n");

AS_CBUFF(InstructionName,"CannotPlayOnline_SparkRequired_Message",0x1E,0x3,0x7);
SwapStringRDX(
"CannotPlayOnline_SparkRequired_Message::ASM",
"BYPASS_ONLINE_BLOCKED2",
"Either Your Offline Or On A EOS Bypass,  "..
"You Cant Play Online With A Bypassed Account!!  "..
"Please Go Online Or Sign Into An Account That Owns The Game To Play Online,  "..
"NHA's Bypass Is For Offline Use!!  "..
"https://github.com/dr-NHA/Wonderlands",
true);
print("\n");


AS_CBUFF(InstructionName,"Network_Error_TITLE",0x94,0x3,0x7);
SwapStringRDX("Network_Error_TITLE::ASM",
"BYPASS_ONLINE_BLOCKED_ERROR",
"dr NHA's Bypass Error!!",
true);
print("\n");

else
createNativeThread(function()
sleep(1000)--Wait A Second Before Starting A Rescan
Wonderlands.FindCannotPlayOnline();
end)
end
end;
end;

--[[
75 0E 48 8B 03 BA ?? ?? 00 00 48 8B CB FF 50 ?? 4C 8D 0D B8DF4803
75 0E 48 8B 03 BA 01 00 00 00 48 8B CB FF 50 08 4C 8D 0D B8 DF 48 03 4C 8D 05 F1 DF 48 03 48 8D 15 ?? ?? ?? ?? 48 8D 4D ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4C 24 68 E8 ?? ?? ?? ?? 48 8B 5D 00 48 85 DB 74 2E 8B C7 F0 0F C1 43 08 83 E8 01 75 22 48 8B 03 48 8B CB FF 10 8B C7 F0 0F C1 43 0C 83 E8 01 75 0E
75 ?? 48 8B 03 BA 01 00 00 00 48 8B CB FF 50 ?? 4C 8D 0D ?? ?? ?? ?? 4C 8D 05 F1 DF 48 03 48 8D 15 ?? ?? ?? ?? 48 8D 4D ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4C 24 68 E8 ?? ?? ?? ?? 48 8B 5D 00 48 85 DB 74 2E 8B C7 F0 0F C1 43 08 83 E8 01 75 ?? 48 8B 03 48 8B CB FF 10 8B C7 F0 0F C1 43 0C 83 E8 01 75 ??
75 ?? 48 8B 03 BA ?? ?? ?? ?? 48 8B CB FF 50 ?? 4C 8D 0D ?? ?? ?? ?? 4C 8D 05 F1 DF 48 03 48 8D 15 ?? ?? ?? ?? 48 8D 4D ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4C 24 68 E8 ?? ?? ?? ?? 48 8B 5D 00 48 85 DB 74 2E 8B C7 F0 0F C1 43 08 83 E8 01 75 ?? 48 8B 03 48 8B CB FF 10 8B C7 F0 0F C1 43 0C 83 E8 01 75 ??
75 ?? 48 8B 03 BA ?? ?? ?? ?? 48 8B CB FF 50 ?? 4C 8D 0D ?? ?? ?? ?? 4C 8D 05 ?? ?? ?? ?? 48 8D 15 ?? ?? ?? ?? 48 8D 4D ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4C 24 68 E8 ?? ?? ?? ?? 48 8B 5D 00 48 85 DB 74 2E 8B C7 F0 0F C1 43 08 83 E8 01 75 ?? 48 8B 03 48 8B CB FF 10 8B C7 F0 0F C1 43 0C 83 E8 01 75 ??
75 ?? 48 8B 03 BA ?? ?? ?? ?? 48 8B CB FF 50 ?? 4C 8D 0D ?? ?? ?? ?? 4C 8D 05 ?? ?? ?? ?? 48 8D 15 ?? ?? ?? ?? 48 8D 4D ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4C 24 68 E8 ?? ?? ?? ?? 48 8B

Wonderlands.exe.tls+B3FF31 - 75 0E                 - jne Wonderlands.exe.tls+B3FF41
Wonderlands.exe.tls+B3FF33 - 48 8B 03              - mov rax,[rbx]
Wonderlands.exe.tls+B3FF36 - BA 01000000           - mov edx,00000001 { 1 }
Wonderlands.exe.tls+B3FF3B - 48 8B CB              - mov rcx,rbx
Wonderlands.exe.tls+B3FF3E - FF 50 08              - call qword ptr [rax+08]
Wonderlands.exe.tls+B3FF41 - 4C 8D 0D B8DF4803     - lea r9,[Wonderlands.exe.trace+41AF00] { ("CannotPlayOnline_SparkRequired") } + 0x10
Wonderlands.exe.tls+B3FF48 - 4C 8D 05 F1DF4803     - lea r8,[Wonderlands.exe.trace+41AF40] { ("OakGameInstance") }
Wonderlands.exe.tls+B3FF4F - 48 8D 15 0AE04803     - lea rdx,[Wonderlands.exe.trace+41AF60] { ("This feature requires all activ") } + 0x1E
Wonderlands.exe.tls+B3FF56 - 48 8D 4D F8           - lea rcx,[rbp-08]
Wonderlands.exe.tls+B3FF5A - E8 A1A7AF00           - call Wonderlands.exe.tls+163A700
Wonderlands.exe.tls+B3FF5F - 48 8B D0              - mov rdx,rax
Wonderlands.exe.tls+B3FF62 - 48 8D 4C 24 68        - lea rcx,[rsp+68]
Wonderlands.exe.tls+B3FF67 - E8 0496AE00           - call Wonderlands.exe.tls+1629570
Wonderlands.exe.tls+B3FF6C - 48 8B 5D 00           - mov rbx,[rbp+00]
Wonderlands.exe.tls+B3FF70 - 48 85 DB              - test rbx,rbx
Wonderlands.exe.tls+B3FF73 - 74 2E                 - je Wonderlands.exe.tls+B3FFA3
Wonderlands.exe.tls+B3FF75 - 8B C7                 - mov eax,edi
Wonderlands.exe.tls+B3FF77 - F0 0FC1 43 08         - lock xadd [rbx+08],eax
Wonderlands.exe.tls+B3FF7C - 83 E8 01              - sub eax,01 { 1 }
Wonderlands.exe.tls+B3FF7F - 75 22                 - jne Wonderlands.exe.tls+B3FFA3
Wonderlands.exe.tls+B3FF81 - 48 8B 03              - mov rax,[rbx]
Wonderlands.exe.tls+B3FF84 - 48 8B CB              - mov rcx,rbx
Wonderlands.exe.tls+B3FF87 - FF 10                 - call qword ptr [rax]
Wonderlands.exe.tls+B3FF89 - 8B C7                 - mov eax,edi
Wonderlands.exe.tls+B3FF8B - F0 0FC1 43 0C         - lock xadd [rbx+0C],eax
Wonderlands.exe.tls+B3FF90 - 83 E8 01              - sub eax,01 { 1 }
Wonderlands.exe.tls+B3FF93 - 75 0E                 - jne Wonderlands.exe.tls+B3FFA3
Wonderlands.exe.tls+B3FF95 - 48 8B 03              - mov rax,[rbx]
Wonderlands.exe.tls+B3FF98 - BA 01000000           - mov edx,00000001 { 1 }
Wonderlands.exe.tls+B3FF9D - 48 8B CB              - mov rcx,rbx
Wonderlands.exe.tls+B3FFA0 - FF 50 08              - call qword ptr [rax+08]
Wonderlands.exe.tls+B3FFA3 - 4C 8B 7D 78           - mov r15,[rbp+78]
Wonderlands.exe.tls+B3FFA7 - 45 32 E4              - xor r12l,r12l
Wonderlands.exe.tls+B3FFAA - 44 38 A5 80000000     - cmp [rbp+00000080],r12l
Wonderlands.exe.tls+B3FFB1 - 0F84 45010000         - je Wonderlands.exe.tls+B400FC
Wonderlands.exe.tls+B3FFB7 - 4C 8D 0D 4AE04803     - lea r9,[Wonderlands.exe.trace+41B008] { ("NetworkError") }
Wonderlands.exe.tls+B3FFBE - 4C 8D 05 63E04803     - lea r8,[Wonderlands.exe.trace+41B028] { ("OakGameInstance") }
Wonderlands.exe.tls+B3FFC5 - 48 8D 15 7CE04803     - lea rdx,[Wonderlands.exe.trace+41B048] { ("Network Error") }+0x94


]]


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





function Wonderlands.FindMOTD()
if Wonderlands.GlobalRescanCount<Wonderlands.GlobalRescanMax then
Wonderlands.GlobalRescanCount=Wonderlands.GlobalRescanCount+1;
if Wonderlands.InstructionBaseScan(--[[Instruction Name]] "MOTD_STORE",
--[[AOB]] "48 8B 05 ?? ?? ?? ?? 48 85 C0 75 23 B9 ?? ?? ?? 00 E8 ?? ?? ?? ?? 48 85 C0 74 0A 48 8B C8 E8 ?? ?? ?? ?? EB ?? 48 8B C3 48 89 05 ?? ?? ?? ??") then;--Found This Instruction
AS_CBUFF("MOTD_STORE","MOTD",0,3,7);
registerSymbol("MOTD_CURRENT","[[[[[MOTD]+30]+1E8]+B40]+0]+A00");
Wonderlands.Find_StringManager();
else
createNativeThread(function()
sleep(1000)--Wait A Second Before Starting A Rescan
Wonderlands.FindMOTD();
end)
end
end;
end

Wonderlands.NHA_MOTD_NEW_AOB="00 00 00 4F 66 66 6C 69 6E 65 4D 6F 74 64 5F 49 6E 6A 65 63";
Wonderlands.NHA_MOTD_NEW=
"Thanks For Using NHA Wonderlands V"..ToolVersion..",\n"..
"There Are Many New Mods And Plenty Of Bug Fixes!\n"..
"Head To My Github For Tool Updates!!!\n"..
"https://github.com/dr-NHA/Wonderlands"
;

function Wonderlands.Find_StringManagerCheck()
if Wonderlands.IsAttached==false then
Wonderlands.RemoveFromModTick("NHA_MOTD_REPLACEMENT");
else if GetAddressSafe("[[OfflineMotd_Injection]+0]+0")~=nil then
local READ=readString("[[OfflineMotd_Injection]+0]+0",600,true)
print("NHA MOTD INJECTION Found: "..READ);
if READ=="Welcome to Tiny Tina's Wonderlands" then
--Default String
writePointer("[OfflineMotd_Injection]+0",getAddress("OfflineMotd_Injected"));
print("Wrote New Modified String To: "..NHA_CE.HEX.GetAddress("[OfflineMotd_Injection]+0"));
elseif READ==Wonderlands.NHA_MOTD_NEW then
--Already Modded!
print("String Was Already Modified: "..NHA_CE.HEX.GetAddress("[OfflineMotd_Injection]+0"));
else
writePointer("[OfflineMotd_Injection]+0",getAddress("OfflineMotd_Injected"))
print("Modified String Was Not What We Expected So We Reinjected It: "..NHA_CE.HEX.GetAddress("[OfflineMotd_Injection]+0"));
end
Wonderlands.RemoveFromModTick("NHA_MOTD_REPLACEMENT");
end
end
end


Wonderlands.StringManagerDistance="08";
Wonderlands.StringManagerJmpBack="14";
Wonderlands.StringManagerAddress=function();return "StringManager+"..Wonderlands.StringManagerDistance;end;
Wonderlands.StringManagerAOB="48 8B 11";


Wonderlands.FindStringManagerEnabled=false;
function Wonderlands.Find_StringManager()
local WasModified=false;
if Wonderlands.FindStringManagerEnabled then
if Wonderlands.InstructionBaseScan(
"StringManager",
"49 8B F8 48 8B F2 74 05") then;
pause()
RegisterSymbol("StringManager",GetAddress("StringManager::ASM"));
RegisterSymbol("StringManagerFunction","StringManager+"..Wonderlands.StringManagerDistance);
registerSymbol("StringManagerJmpBack","StringManager+"..Wonderlands.StringManagerJmpBack);

if NHA_CE.HEX.HexString(Wonderlands.StringManagerAddress(),3)==Wonderlands.StringManagerAOB then
print("String Manager Is Not Yet Modified!");
else
WasModified=true;
print("String Manager Is Already Modified And An Injected Function Is In Its Place!");
end


unregisterSymbol("StringManagerInjectionSuccess");
unregisterSymbol("StringManagerInjectionAttempt2");

unregisterSymbol("OfflineMotd_InjectedX");
CheckForInjectedString_REFSYMBOL("OfflineMotd_InjectedX",  Wonderlands.NHA_MOTD_NEW_AOB,  Wonderlands.NHA_MOTD_NEW,  true);

if GetAddressSafe("OfflineMotd_InjectedX")==nil then
print('OfflineMotd_Injected Alloceted');
unregisterSymbol("OfflineMotd_Injected");
RegisterSymbol("OfflineMotd_Injected",AllocateNewString("OfflineMotd_Injected",Wonderlands.NHA_MOTD_NEW,true));
else
registerSymbol("OfflineMotd_Injected",getAddress("OfflineMotd_InjectedX"))
unregisterSymbol("OfflineMotd_InjectedX")
end


if GetAddressSafe("StringManagerInjection")~=nil then
print('**StringManagerInjection De-Alloceted');
deAlloc(getAddress("StringManagerInjection"),0x1000)
unregisterSymbol("StringManagerInjection");
end
print('StringManagerInstruction Alloceted');
registerSymbol("StringManagerInjection",AllocateExeMemory(0x1000));

if GetAddressSafe("OfflineMotd_Injection")~=nil then
print('**OfflineMotd_Injection De-Alloceted');
deAlloc(getAddress("OfflineMotd_Injection"),0x8)
unregisterSymbol("OfflineMotd_Injection");
end
print('OfflineMotd_Injection Alloceted');
registerSymbol("OfflineMotd_Injection",AllocateExeMemory(0x8));

if GetAddressSafe("OfflineMotd_Injected_Pointer")~=nil then
--print('**OfflineMotd_Injected_Pointer De-Alloceted');
--deAlloc(getAddress("OfflineMotd_Injected_Pointer"),0x8)
unregisterSymbol("OfflineMotd_Injected_Pointer");
end
print('OfflineMotd_Injected_Pointer Alloceted');
registerSymbol("OfflineMotd_Injected_Pointer",AllocateExeMemory(0x8));
writePointer("OfflineMotd_Injected_Pointer",getAddress("OfflineMotd_Injected"));

if autoAssemble(
[[
label(StringManagerInjectionSuccess StringManagerInjectionAttempt2);
registerSymbol(StringManagerInjectionSuccess StringManagerInjectionAttempt2)

StringManagerInjection:
mov rdx,[rcx]
cmp rdx,MOTD_CURRENT
je StringManagerInjectionSuccess
jmp StringManagerInjectionAttempt2
nop
nop
nop
StringManagerInjectionSuccess:
mov [OfflineMotd_Injection],rcx
jmp StringManagerJmpBack
nop
nop
nop
StringManagerInjectionAttempt2:
cmp rdx,[OfflineMotd_Injected_Pointer]
je StringManagerInjectionSuccess
jmp StringManagerJmpBack
nop
nop

StringManagerFunction:
jmp StringManagerInjection

]]
) then
print("Waiting For The Motd To Be Loaded Into The StringManager");
Wonderlands.AddToModTick("NHA_MOTD_REPLACEMENT",Wonderlands.Find_StringManagerCheck)
else
print("StringManagerInjection Failed!");
if NHA_CE.HEX.HexString(Wonderlands.StringManagerAddress(),3)~=Wonderlands.StringManagerAOB then
writeBytes(Wonderlands.StringManagerAddress(),NHA_CE.HEX.ConvertStringToBytes(stringin));
print("StringManagerInjection Cleaned And Reset!!");
end
end

end
end
unpause();
end


--[[
MOTD
48 8B 05 ?? ?? ?? ?? 48 85 C0 75 23 B9 ?? ?? ?? 00 E8 ?? ?? ?? ?? 48 85 C0 74 0A 48 8B C8 E8 ?? ?? ?? ?? EB ?? 48 8B C3 48 89 05 ?? ?? ?? ??
Wonderlands.exe.tls+1621010 - 48 8B 05 ?? ?? ?? ??     - mov rax,[Wonderlands.exe+6510068] { (039601C0) } <<<<<<<<<<<<< OFFSET
Wonderlands.exe.tls+1621017 - 48 85 C0              - test rax,rax
Wonderlands.exe.tls+162101A - 75 23                 - jne Wonderlands.exe.tls+162103F
Wonderlands.exe.tls+162101C - B9 10010000           - mov ecx,00000110 { 272 }
Wonderlands.exe.tls+1621021 - E8 FAB7F6FE           - call Wonderlands.AK::WriteBytesMem::Count+6C10
Wonderlands.exe.tls+1621026 - 48 85 C0              - test rax,rax
Wonderlands.exe.tls+1621029 - 74 0A                 - je Wonderlands.exe.tls+1621035
Wonderlands.exe.tls+162102B - 48 8B C8              - mov rcx,rax
Wonderlands.exe.tls+162102E - E8 6D550000           - call Wonderlands.exe.tls+16265A0
Wonderlands.exe.tls+1621033 - EB 03                 - jmp Wonderlands.exe.tls+1621038
Wonderlands.exe.tls+1621035 - 48 8B C3              - mov rax,rbx
Wonderlands.exe.tls+1621038 - 48 89 05 29E0EE04     - mov [Wonderlands.exe+6510068],rax { (039601C0) }

]]




function Wonderlands.Find_DISCORD_DATA()
if Wonderlands.GlobalRescanCount<Wonderlands.GlobalRescanMax then
Wonderlands.GlobalRescanCount=Wonderlands.GlobalRescanCount+1;
if Wonderlands.InstructionBaseScan(--[[Instruction Name]] "DISCORD_RPC",
--[[AOB]] "48 8D 15 ?? ?? ?? ?? 4C 8D 05 ?? ?? ?? ?? 4C 8D 0D ?? ?? ?? ?? EB 1C 48 8D 4D ?? 41 8B F6 48 8D 15 ?? ?? ?? ?? 4C 8D 05 ?? ?? ?? ?? 4C 8D 0D ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4D ?? E8 ?? ?? ?? ?? 41 84 F6") then;--Found This Instruction
print("\n");
AS_CBUFF("DISCORD_RPC","GAME_LEVEL_STATE",0,3,7);
SwapStringRDX("GAME_LEVEL_STATE::ASM",
"TOOL_INFO",
"NHA Wonderlands V"..ToolVersion,
true);
print("\n");
AS_CBUFF("DISCORD_RPC","GAME_MENU_STATE",0x1E,3,7);
SwapStringRDX("GAME_MENU_STATE::ASM",
"TOOL_INFO",
"NHA Wonderlands V"..ToolVersion,
true);
print("\n");
AS_CBUFF("DISCORD_RPC","CHARACTER_INFO",0x14F,3,7);
SwapStringRDX("CHARACTER_INFO::ASM",
"TOOL_AUTHOR",
"Cheat Table Made By: dr NHA!!",
true);
print("\n");
else
createNativeThread(function()
sleep(1000)--Wait A Second Before Starting A Rescan
Wonderlands.Find_DISCORD_DATA();
end)
end
end;
end
--[[

48 8D 15 ?? ?? ?? ?? 4C 8D 05 ?? ?? ?? ?? 4C 8D 0D ?? ?? ?? ?? EB 1C 48 8D 4D ?? 41 8B F6 48 8D 15 ?? ?? ?? ?? 4C 8D 05 ?? ?? ?? ?? 4C 8D 0D ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 8B D0 48 8D 4D ?? E8 ?? ?? ?? ?? 41 84 F6              - test r14l,sil
Wonderlands.exe.tls+D82DB4 - 74 3A                 - je Wonderlands.exe.tls+D82DF0
Wonderlands.exe.tls+D82DB6 - 48 8B 5D ??           - mov rbx,[rbp+10]
Wonderlands.exe.tls+D82DBA - 83 E6 ??              - and esi,-03 { 253 }
Wonderlands.exe.tls+D82DBD - 48 85 DB              - test rbx,rbx
Wonderlands.exe.tls+D82DC0 - 74 ??                 - je Wonderlands.exe.tls+D82DF0
Wonderlands.exe.tls+D82DC2 - 8B C7                 - mov eax,edi
Wonderlands.exe.tls+D82DC4 - F0 0F C1 43 ??         - lock xadd [rbx+08],eax
Wonderlands.exe.tls+D82DC9 - 83 F8 01              - cmp eax,01 { 1 }
Wonderlands.exe.tls+D82DCC - 75 22                 - jne Wonderlands.exe.tls+D82DF0
Wonderlands.exe.tls+D82DCE - 48 8B 03              - mov rax,[rbx]
Wonderlands.exe.tls+D82DD1 - 48 8B CB              - mov rcx,rbx
Wonderlands.exe.tls+D82DD4 - FF 10                 - call qword ptr [rax]
Wonderlands.exe.tls+D82DD6 - 8B C7                 - mov eax,edi
Wonderlands.exe.tls+D82DD8 - F0 0F C1 43 ??         - lock xadd [rbx+0C],eax
Wonderlands.exe.tls+D82DDD - 83 F8 01              - cmp eax,01 { 1 }
Wonderlands.exe.tls+D82DE0 - 75 0E                 - jne Wonderlands.exe.tls+D82DF0
Wonderlands.exe.tls+D82DE2 - 48 8B 03              - mov rax,[rbx]
Wonderlands.exe.tls+D82DE5 - BA 01000000           - mov edx,00000001 { 1 }
Wonderlands.exe.tls+D82DEA - 48 8B CB              - mov rcx,rbx
Wonderlands.exe.tls+D82DED - FF 50 08              - call qword ptr [rax+08]
Wonderlands.exe.tls+D82DF0 - 40 F6 C6 01           - test sil,01 { 1 }
Wonderlands.exe.tls+D82DF4 - 74 37                 - je Wonderlands.exe.tls+D82E2D
Wonderlands.exe.tls+D82DF6 - 48 8B 5D 28           - mov rbx,[rbp+28]
Wonderlands.exe.tls+D82DFA - 48 85 DB              - test rbx,rbx
Wonderlands.exe.tls+D82DFD - 74 2E                 - je Wonderlands.exe.tls+D82E2D
Wonderlands.exe.tls+D82DFF - 8B C7                 - mov eax,edi
Wonderlands.exe.tls+D82E01 - F0 0FC1 43 08         - lock xadd [rbx+08],eax
Wonderlands.exe.tls+D82E06 - 83 F8 01              - cmp eax,01 { 1 }
Wonderlands.exe.tls+D82E09 - 75 22                 - jne Wonderlands.exe.tls+D82E2D
Wonderlands.exe.tls+D82E0B - 48 8B 03              - mov rax,[rbx]
Wonderlands.exe.tls+D82E0E - 48 8B CB              - mov rcx,rbx
Wonderlands.exe.tls+D82E11 - FF 10                 - call qword ptr [rax]
Wonderlands.exe.tls+D82E13 - 8B C7                 - mov eax,edi
Wonderlands.exe.tls+D82E15 - F0 0FC1 43 0C         - lock xadd [rbx+0C],eax
Wonderlands.exe.tls+D82E1A - 83 F8 01              - cmp eax,01 { 1 }
Wonderlands.exe.tls+D82E1D - 75 0E                 - jne Wonderlands.exe.tls+D82E2D
Wonderlands.exe.tls+D82E1F - 48 8B 03              - mov rax,[rbx]
Wonderlands.exe.tls+D82E22 - BA 01000000           - mov edx,00000001 { 1 }
Wonderlands.exe.tls+D82E27 - 48 8B CB              - mov rcx,rbx
Wonderlands.exe.tls+D82E2A - FF 50 08              - call qword ptr [rax+08]
Wonderlands.exe.tls+D82E2D - 48 8D 4D 88           - lea rcx,[rbp-78]
Wonderlands.exe.tls+D82E31 - E8 FAA88C00           - call Wonderlands.exe.tls+164D730
Wonderlands.exe.tls+D82E36 - 48 8B F0              - mov rsi,rax
Wonderlands.exe.tls+D82E39 - 4C 8D 25 E0F2EA02     - lea r12,[Wonderlands.exe.trace+7F120] { (0) }
Wonderlands.exe.tls+D82E40 - 83 78 08 00           - cmp dword ptr [rax+08],00 { 0 }
Wonderlands.exe.tls+D82E44 - 74 05                 - je Wonderlands.exe.tls+D82E4B
Wonderlands.exe.tls+D82E46 - 48 8B 10              - mov rdx,[rax]
Wonderlands.exe.tls+D82E49 - EB 03                 - jmp Wonderlands.exe.tls+D82E4E
Wonderlands.exe.tls+D82E4B - 49 8B D4              - mov rdx,r12
Wonderlands.exe.tls+D82E4E - 41 83 BD 98000000 00  - cmp dword ptr [r13+00000098],00 { 0 }
Wonderlands.exe.tls+D82E56 - 74 09                 - je Wonderlands.exe.tls+D82E61
Wonderlands.exe.tls+D82E58 - 49 8B 8D 90000000     - mov rcx,[r13+00000090]
Wonderlands.exe.tls+D82E5F - EB 03                 - jmp Wonderlands.exe.tls+D82E64
Wonderlands.exe.tls+D82E61 - 49 8B CC              - mov rcx,r12
Wonderlands.exe.tls+D82E64 - E8 17FA6DFF           - call Wonderlands.AK::MemoryMgr::GetPoolName+22D0
Wonderlands.exe.tls+D82E69 - 85 C0                 - test eax,eax
Wonderlands.exe.tls+D82E6B - 74 13                 - je Wonderlands.exe.tls+D82E80
Wonderlands.exe.tls+D82E6D - 48 8B D6              - mov rdx,rsi
Wonderlands.exe.tls+D82E70 - 49 8D 8D 90000000     - lea rcx,[r13+00000090]
Wonderlands.exe.tls+D82E77 - E8 540E6EFF           - call Wonderlands.AK::MemoryMgr::GetPoolName+3720
Wonderlands.exe.tls+D82E7C - B0 01                 - mov al,01 { 1 }
Wonderlands.exe.tls+D82E7E - EB 02                 - jmp Won~~derlands.exe.tls+D82E82
Wonderlands.exe.tls+D82E80 - 32 C0                 - xor al,al
Wonderlands.exe.tls+D82E82 - 08 44 24 20           - or [rsp+20],al
Wonderlands.exe.tls+D82E86 - 48 8D 4D B0           - lea rcx,[rbp-50]
Wonderlands.exe.tls+D82E8A - E8 E10C8A00           - call Wonderlands.exe.tls+1623B70
Wonderlands.exe.tls+D82E8F - 45 84 FF              - test r15l,r15l
Wonderlands.exe.tls+D82E92 - 0F85 64020000         - jne Wonderlands.exe.tls+D830FC
Wonderlands.exe.tls+D82E98 - 48 8B 54 24 38        - mov rdx,[rsp+38]
Wonderlands.exe.tls+D82E9D - 48 8D 4D 78           - lea rcx,[rbp+78]
Wonderlands.exe.tls+D82EA1 - E8 9A0C8A00           - call Wonderlands.exe.tls+1623B40
Wonderlands.exe.tls+D82EA6 - 4C 8D 0D 53023803     - lea r9,[Wonderlands.exe.trace+550100] { ("DiscordDetails") }
Wonderlands.exe.tls+D82EAD - 48 89 44 24 38        - mov [rsp+38],rax
Wonderlands.exe.tls+D82EB2 - 4C 8D 05 67023803     - lea r8,[Wonderlands.exe.trace+550120] { ("DiscordManager") }
Wonderlands.exe.tls+D82EB9 - 48 8B D8              - mov rbx,rax
Wonderlands.exe.tls+D82EBC - 48 8D 15 9DB02403     - lea rdx,[CannotPlayOnline_SparkRequired_Message::BASE] { ("Either Your Offline Or On A EOS") }
]]





function RestoreAllPools()
print("Restoring Pools!");
if RestorePoolsCount> 1 then
for IND=1,RestorePoolsCount-1,1 do
RestorePools[IND]();
end
end
RestorePoolsCount=1;
RestorePools={};
end


Wonderlands.OnGameExitToMainMenu_Injection=function()
if GetAddressSafe("OnGameExitToMainMenu")~=nil then
autoAssemble([[

OnGameExitToMainMenu:
  db C6 43 30 01 48 8B 8F 20 02 00 00

unregistersymbol(OnGameExitToMainMenu)
dealloc(OnGameExitToMainMenuINJECTED)

]])
print("OnGameExitToMainMenu Was Fixed!");

end


if Wonderlands.InstructionBaseScan(
"OnGameExitToMainMenu",
"C6 43 30 01 48 8B 8F 20 02 00 00") then
registerSymbol("OnGameExitToMainMenu",GetAddress("OnGameExitToMainMenu::ASM"));
unregisterSymbol("OnGameExitToMainMenu::ASM");
registerSymbol("OnGameExitToMainMenuINJECTED",AllocateExeMemory(200));
registerSymbol("GameIsExitingToMainMenu",AllocateExeMemory(4));

if autoAssemble([[

label(return )

OnGameExitToMainMenuINJECTED:
  mov byte ptr [rbx+30],01
  mov [GameIsExitingToMainMenu],01
  mov rcx,[rdi+CBalanceState.PartsList]
  jmp return

OnGameExitToMainMenu:
  jmp OnGameExitToMainMenuINJECTED
  nop 6

return:

]]) then
print("Detection Started For When You Have Selected To Quit To Main Menu");


if Wonderlands.GameExitThread==nil then;
Wonderlands.GameExitThread=createThread(function()
while true do
if readByte(GetAddress("GameIsExitingToMainMenu"))==1 then
if RestorePoolsCount> 1 then
pause();
print("Detected You Have Selected To Quit To Main Menu And You Have Pools That Have Been Swapped!!");
writeByte(GetAddress("GameIsExitingToMainMenu"),0);
local CC=RestorePoolsCount;
RestoreAllPools();
sleep(12*CC);
sleep(220);
unpause();
else
sleep(200);
end
end
sleep(10);
end
end);
Wonderlands.GameExitThread.Name="GameExitThread";
end
else
print("Error OnGameExitToMainMenu Injected Code Couldnt Be Injected!");
unregisterSymbol("OnGameExitToMainMenu");
end;


end


end