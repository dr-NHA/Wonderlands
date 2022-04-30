
--[[
Function To Call Each Offset Scanner
]]
function Wonderlands.FindOffsets()
Wonderlands.PrintLuaSplit();
print("Finding Game Offsets:\n");
Wonderlands.FindGameViewport();--Get The Game GameViewport Offset
Wonderlands.FindWorld();--Get The Game World Offset
Wonderlands.FindBPGameState_Default_C();--Get The BPGameState_Default_C Offset
Wonderlands.FindPlayerArray();--Get The PlayerArray Offset
Wonderlands.FindAmmoRegenRate();
Wonderlands.FindPlayerAbilityManagerComponent();
Wonderlands.FindPlayerAbilityTree();
Wonderlands.FindPlayerAbilityTreeItems();
Wonderlands.OnScansCompleted();
end





--[[
Wonderlands Offset Scanning:
Find The Offsets By Instructions Not By A Dumper!
]]


function Wonderlands.FindGameViewport();
local INSTRUCTIONNAME="GameEngine.GameViewport";
local AOB="48 8B 8F ?? ?? 00 00 48 85 C9 74 25 48 8B 01 FF 90";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"GameEngine.GameViewport"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end
end;



function Wonderlands.FindWorld();
local INSTRUCTIONNAME="GameViewport.World";
local AOB="48 05 ?? ?? 00 00 48 63 50 08 3B 91 ?? ?? 00 00 7F 11 48 8B 89 ?? ?? 00 00";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"GameViewport.World"--[[Offset Name]],0x12--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end;
end;

function Wonderlands.FindBPGameState_Default_C();
local INSTRUCTIONNAME="World.BPGameState_Default_C";
local AOB="48 89 83 ?? ?? 00 00 4C 8B 41 ?? 4C 89 43 ?? 48 8B 41 ?? 48 89 83 ?? ?? 00 00 4D 85 C0 74 30 8B C6";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"World.BPGameState_Default_C"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end;
end;

function Wonderlands.FindPlayerArray();
local INSTRUCTIONNAME="BPGameState_Default_C.PlayerArray";
local AOB="48 8B 9F ?? ?? 0? 00 48 63 87 ?? ?? 0? 00 4C 8D 24 C3 49 3B DC 0F 84 ?? ?? 00 00 4C 89 7C 24 ?? 0F 1F 84 00";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"BPGameState_Default_C.PlayerArray"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
{"BPGameState_Default_C.PlayerArray_size"--[[Offset Name]],0x7--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end;
end;

function Wonderlands.FindAmmoRegenRate();
local INSTRUCTIONNAME="PlayerController.AmmoRegenRateInstruction";
local AOB="0F 2F B9 ?? ?? 00 00 0F 83 ?? ?? 00 00 48 89 74 24 ?? 33 D2 48 89 7C 24 ?? E8 ?? ?? ?? ??";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"PlayerController.AmmoRegenRate"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then

end;
end;



function Wonderlands.FindPlayerAbilityManagerComponent();
local INSTRUCTIONNAME="PlayerController.PlayerAbilityManagerComponentInstruction";
local AOB="4C 8B B0 ?? ?? 00 00 4D 85 F6 0F 84 ?? ?? 00 00 48 8D 15 ?? ?? ?? ?? 49 8B DD";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"PlayerController.PlayerAbilityManagerComponent"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then

end;
end;

--[[
PlayerController.PlayerAbilityManagerComponent
4C 8B B0 ?? ?? 00 00 4D 85 F6 0F 84 ?? ?? 00 00 48 8D 15 ?? ?? ?? ?? 49 8B DD
Wonderlands.exe.tls+1247353 - 4C 8B B0 502C0000     - mov r14,[rax+00002C50]
Wonderlands.exe.tls+124735A - 4D 85 F6              - test r14,r14
Wonderlands.exe.tls+124735D - 0F84 42010000         - je Wonderlands.exe.tls+12474A5
Wonderlands.exe.tls+1247363 - 48 8D 15 16AEAC02     - lea rdx,[Wonderlands.exe.trace+15F180] { (003A003A) }
Wonderlands.exe.tls+124736A - 49 8B DD              - mov rbx,r13
Wonderlands.exe.tls+124736D - 48 8D 0D 0C2A0C03     - lea rcx,[Wonderlands.exe.trace+756D80] { ("&AOakCharacter_StandIn::OnPlaye") }
]]




function Wonderlands.FindPlayerAbilityTree();
local INSTRUCTIONNAME="PlayerAbilityManagerComponent.PlayerAbilityTreeInstruction";
local AOB="48 8B B0 ?? ?? 00 00 48 89 ?? ?? 48 85 F6 0F 84 ?? ?? 00 00 48 89";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"PlayerAbilityManagerComponent.PlayerAbilityTree"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then

end;
end;
--[[
PlayerAbilityManagerComponent.PlayerAbilityTree
48 8B B0 ?? ?? 00 00 48 89 ?? ?? 48 85 F6 0F 84 ?? ?? 00 00 48 89
Wonderlands.exe.tls+FA4F16 - 48 8B B0 D0040000     - mov rsi,[rax+000004D0]
Wonderlands.exe.tls+FA4F1D - 48 89 75 C0           - mov [rbp-40],rsi
Wonderlands.exe.tls+FA4F21 - 48 85 F6              - test rsi,rsi
Wonderlands.exe.tls+FA4F24 - 0F84 09270000         - je Wonderlands.exe.tls+FA7633
Wonderlands.exe.tls+FA4F2A - 48 89 BC 24 700C0000  - mov [rsp+00000C70],rdi
Wonderlands.exe.tls+FA4F32 - 4C 89 A4 24 780C0000  - mov [rsp+00000C78],r12
Wonderlands.exe.tls+FA4F3A - 45 32 E4              - xor r12l,r12l
]]



function Wonderlands.FindPlayerAbilityTreeItems();
local INSTRUCTIONNAME="PlayerAbilityTree.ItemsInstruction";
local AOB="49 03 82 ?? ?? 00 00 74 32 0F 1F 44 00 00";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"PlayerAbilityTree.Items"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then

end;
end;
--[[
PlayerAbilityTree.Items
49 03 82 ?? ?? 00 00 74 32 0F 1F 44 00 00
Wonderlands.exe.tls+928032 - 49 03 82 A8000000     - add rax,[r10+000000A8]
Wonderlands.exe.tls+928039 - 74 32                 - je Wonderlands.exe.tls+92806D
Wonderlands.exe.tls+92803B - 0F1F 44 00 00         - nop dword ptr [rax+rax+00]
Wonderlands.exe.tls+928040 - 44 03 40 28           - add r8d,[rax+28]
Wonderlands.exe.tls+928044 - 48 8B 08              - mov rcx,[rax]
Wonderlands.exe.tls+928047 - 48 85 C9              - test rcx,rcx
Wonderlands.exe.tls+92804A - 74 21                 - je Wonderlands.exe.tls+92806D
]]

