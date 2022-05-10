
--[[
Function To Call Each Offset Scanner
]]
function Wonderlands.FindOffsets()
Wonderlands.PrintLuaSplit();--Splits The Offset Loader Debug Prints From The Other Prints
print("Finding Game Offsets:\n");
Wonderlands.OffsetHooks.FindGameViewport();--Get The Game GameViewport Offset
Wonderlands.OffsetHooks.FindWorld();--Get The Game World Offset
Wonderlands.OffsetHooks.FindBPGameState_Default_C();--Get The BPGameState_Default_C Offset
Wonderlands.OffsetHooks.FindPlayerArray();--Get The PlayerArray Offset

--Object
print("\nFinding Object Offsets:\n");
Wonderlands.OffsetHooks.FindObjectOwner()
Wonderlands.OffsetHooks.FindObjectRootComponent();
--Player
print("\nFinding Player Offsets:\n");
Wonderlands.OffsetHooks.FindPlayerCharacter();
Wonderlands.OffsetHooks.FindAmmoRegenRate();
Wonderlands.OffsetHooks.FindPlayerAbilityManagerComponent();
Wonderlands.OffsetHooks.FindPlayerAbilityTree();
Wonderlands.OffsetHooks.FindPlayerAbilityTreeItems();
Wonderlands.OffsetHooks.FindPlayerEquippedItems();
--FINISHED
Wonderlands.OnScansCompleted();
end

--[[
The OffsetHooks Base / Mother / Parent / Owner / Array
]]
Wonderlands.OffsetHooks={};


--[[
Wonderlands Offset Scanning:
Find The Offsets By Instructions Not By A Dumper!
]]


Wonderlands.OffsetHooks.FindGameViewport=function();
local INSTRUCTIONNAME="GameEngine.GameViewport";
local AOB="48 8B 8F ?? ?? 00 00 48 85 C9 74 25 48 8B 01 FF 90";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"GameEngine.GameViewport"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end
end;



Wonderlands.OffsetHooks.FindWorld=function();
local INSTRUCTIONNAME="GameViewport.World";
local AOB="48 05 ?? ?? 00 00 48 63 50 08 3B 91 ?? ?? 00 00 7F 11 48 8B 89 ?? ?? 00 00";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"GameViewport.World"--[[Offset Name]],0x12--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end;
end;

Wonderlands.OffsetHooks.FindBPGameState_Default_C=function();
local INSTRUCTIONNAME="World.BPGameState_Default_C";
local AOB="48 89 83 ?? ?? 00 00 4C 8B 41 ?? 4C 89 43 ?? 48 8B 41 ?? 48 89 83 ?? ?? 00 00 4D 85 C0 74 30 8B C6";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"World.BPGameState_Default_C"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end;
end;

Wonderlands.OffsetHooks.FindPlayerArray=function();
local INSTRUCTIONNAME="BPGameState_Default_C.PlayerArray";
local AOB="48 8B 9F ?? ?? 0? 00 48 63 87 ?? ?? 0? 00 4C 8D 24 C3 49 3B DC 0F 84 ?? ?? 00 00 4C 89 7C 24 ?? 0F 1F 84 00";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"BPGameState_Default_C.PlayerArray"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
{"BPGameState_Default_C.PlayerArray_size"--[[Offset Name]],0x7--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]}
}) then

end;
end;


Wonderlands.OffsetHooks.FindPlayerCharacter=function();
local INSTRUCTIONNAME="Player.PlayerCharacter_Instruction";
local AOB="57 48 83 EC ?? 48 8B 81 ?? ?? 0? 00 48 8B DA 48 8B F9 48 3B C2 74 22 48 89 54 24";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"Player.PlayerCharacter"--[[Offset Name]],0x5--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then
end;
end;
--[[
PlayerCharacter
57 48 83 EC ?? 48 8B 81 ?? ?? 0? 00 48 8B DA 48 8B F9 48 3B C2 74 22 48 89 54 24
Wonderlands.exe.tls+DD1840 - 48 89 5C 24 08        - mov [rsp+08],rbx
Wonderlands.exe.tls+DD1845 - 57                    - push rdi
Wonderlands.exe.tls+DD1846 - 48 83 EC 30           - sub rsp,30 { 48 }
Wonderlands.exe.tls+DD184A - 48 8B 81 80060000     - mov rax,[rcx+00000680] << offset
Wonderlands.exe.tls+DD1851 - 48 8B DA              - mov rbx,rdx
Wonderlands.exe.tls+DD1854 - 48 8B F9              - mov rdi,rcx
Wonderlands.exe.tls+DD1857 - 48 3B C2              - cmp rax,rdx
Wonderlands.exe.tls+DD185A - 74 22                 - je Wonderlands.exe.tls+DD187E
Wonderlands.exe.tls+DD185C - 48 89 54 24 20        - mov [rsp+20],rdx
Wonderlands.exe.tls+DD1861 - 48 81 C1 88060000     - add rcx,00000688 { 1672 }
Wonderlands.exe.tls+DD1868 - 48 8D 54 24 20        - lea rdx,[rsp+20]
Wonderlands.exe.tls+DD186D - 48 89 44 24 28        - mov [rsp+28],rax
Wonderlands.exe.tls+DD1872 - E8 09A56AFF           - call Wonderlands.exe.tls+47BD80
Wonderlands.exe.tls+DD1877 - 48 89 9F 80060000     - mov [rdi+00000680],rbx << offset
Wonderlands.exe.tls+DD187E - 48 8B 5C 24 40        - mov rbx,[rsp+40]
Wonderlands.exe.tls+DD1883 - 48 83 C4 30           - add rsp,30 { 48 }
Wonderlands.exe.tls+DD1887 - 5F                    - pop rdi
Wonderlands.exe.tls+DD1888 - C3                    - ret 

]]


Wonderlands.OffsetHooks.FindObjectRootComponent=function();
local INSTRUCTIONNAME="Object.RootComponentInstruction";
local AOB="48 8B 82 ?? ?? 00 00 4D 8B BE ?? ?? 00 00 48 85 C0 74 23 0F 10 88 ?? ?? 00 00";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"Object.RootComponent"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then
end;
end;
--[[
RootComponent
48 8B 82 ?? ?? 00 00 4D 8B BE ?? ?? 00 00 48 85 C0 74 23 0F 10 88 ?? ?? 00 00
Wonderlands.exe.tls+D81A76 - 48 8B 82 68010000     - mov rax,[rdx+00000168]<<RootComponent
Wonderlands.exe.tls+D81A7D - 4D 8B BE 10020000     - mov r15,[r14+00000210]
Wonderlands.exe.tls+D81A84 - 48 85 C0              - test rax,rax
Wonderlands.exe.tls+D81A87 - 74 23                 - je Wonderlands.exe.tls+D81AAC
Wonderlands.exe.tls+D81A89 - 0F10 88 20020000      - movups xmm1,[rax+00000220]
]]



Wonderlands.OffsetHooks.FindObjectOwner=function();
local INSTRUCTIONNAME="Object.Owner";
local AOB="48 89 B3 ?? ?? 00 00 E8 ?? ?? ?? ?? 48 85 C0 74 0E 4C 8B C7 48 8B D3 48 8B C8";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"Object.Owner"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then
end;
end;
--[[
Owner
48 89 B3 ?? ?? 00 00 E8 ?? ?? ?? ?? 48 85 C0 74 0E 4C 8B C7 48 8B D3 48 8B C8
Wonderlands.exe.tls+2229CEC - 48 89 B3 18010000     - mov [rbx+00000118],rsi
Wonderlands.exe.tls+2229CF3 - E8 3837FFFF           - call Wonderlands.exe.tls+221D430
Wonderlands.exe.tls+2229CF8 - 48 85 C0              - test rax,rax
Wonderlands.exe.tls+2229CFB - 74 0E                 - je Wonderlands.exe.tls+2229D0B
Wonderlands.exe.tls+2229CFD - 4C 8B C7              - mov r8,rdi
Wonderlands.exe.tls+2229D00 - 48 8B D3              - mov rdx,rbx
Wonderlands.exe.tls+2229D03 - 48 8B C8              - mov rcx,rax
Wonderlands.exe.tls+2229D06 - E8 E5803A00           - call Wonderlands.exe.tls+25D1DF0
Wonderlands.exe.tls+2229D0B - 48 8B BB 18010000     - mov rdi,[rbx+00000118]

]]

Wonderlands.OffsetHooks.FindAmmoRegenRate=function();
local INSTRUCTIONNAME="PlayerController.AmmoRegenRateInstruction";
local AOB="0F 2F B9 ?? ?? 00 00 0F 83 ?? ?? 00 00 48 89 74 24 ?? 33 D2 48 89 7C 24 ?? E8 ?? ?? ?? ??";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"PlayerController.AmmoRegenRate"--[[Offset Name]],0x0--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then

end;
end;



Wonderlands.OffsetHooks.FindPlayerAbilityManagerComponent=function();
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




Wonderlands.OffsetHooks.FindPlayerAbilityTree=function();
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



Wonderlands.OffsetHooks.FindPlayerAbilityTreeItems=function();
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



Wonderlands.OffsetHooks.FindPlayerEquippedItems=function();
local INSTRUCTIONNAME="PlayerController.EquippedInventoryInstruction";
local AOB="80 B9 ?? ?? ?? 00 03 0F 85 ?? ?? ?? 00 48 63 81 ?? ?? ?? 00 48 89 5C 24 ?? 48 8B 99 ?? ?? ?? 00 48 89 74 24 ?? 48 8D 34 40 48 C1 E6 ??";
if Wonderlands.OffsetScanner(INSTRUCTIONNAME,AOB,{
{"PlayerController.EquippedInventory"--[[Offset Name]],0x19--[[Instruction Distance]],true--[[Extract + Value Not - Value?]]},
}) then

end;
end;
--[[
PlayerAbilityTree.Items
80 B9 ?? ?? ?? 00 03 0F 85 ?? ?? ?? 00 48 63 81 ?? ?? ?? 00 48 89 5C 24 ?? 48 8B 99 ?? ?? ?? 00 48 89 74 24 ?? 48 8D 34 40 48 C1 E6 ??
Wonderlands.exe.tls+DCE564 - 80 B9 28010000 03     - cmp byte ptr [rcx+00000128],03 { 3 }
Wonderlands.exe.tls+DCE56B - 0F85 B4000000         - jne Wonderlands.exe.tls+DCE625
Wonderlands.exe.tls+DCE571 - 48 63 81 10160000     - movsxd  rax,dword ptr [rcx+00001610] <<<<< Offset
Wonderlands.exe.tls+DCE578 - 48 89 5C 24 30        - mov [rsp+30],rbx
Wonderlands.exe.tls+DCE57D - 48 8B 99 08160000     - mov rbx,[rcx+00001608] <<< COUNT
Wonderlands.exe.tls+DCE584 - 48 89 74 24 38        - mov [rsp+38],rsi
Wonderlands.exe.tls+DCE589 - 48 8D 34 40           - lea rsi,[rax+rax*2]
Wonderlands.exe.tls+DCE58D - 48 C1 E6 04           - shl rsi,04 { 4 }
Wonderlands.exe.tls+DCE591 - 48 03 F3              - add rsi,rbx
Wonderlands.exe.tls+DCE594 - 48 3B DE              - cmp rbx,rsi
Wonderlands.exe.tls+DCE597 - 0F84 7E000000         - je Wonderlands.exe.tls+DCE61B

]]


