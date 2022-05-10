--[[
This Lua Script Can Be Used For Majority Of X64 Games
Will Work On The Game Engine Specific Dumpers,

Currently Working:
Launch Arg Dumper, 2X Methods For X64
Unity Engine Mono Base Dumper For X64 Unity Games
Unreal Engine GEngine Base Finder For X64 Unreal Engine Games (May Not Work For Older And Some More Unique Games)
]]

--[[
NHA's CE LUA Helpful Functions!
]]
--The Base CE Table For My Extension Functions
NHA_CE={};


--[[
Hook3r Functions
]]
--Hooker Table
NHA_CE.Hook3r={};
--Allow The Print Function To Work
NHA_CE.Hook3r.AllowPrints=true;
--Print Prefix
local DB3XX="NHA Hook3r: ";

--The Hook3r Print Function < For Debugging
function NHA_CE.Hook3r.Print(str);
if NHA_CE.Hook3r.AllowPrints then;
if str=="~@" then;print(" ");else;print(DB3XX..str);end;end;
end

--[[
Function To Clear Logs
]]
function NHA_CE.Hook3r.ClearLogs()
GetLuaEngine().MenuItem5.doClick();--Click The Clear Button In The Lua Console/Executor
end;
NHA_CE.Hook3r.ClearLogs();


--[[Storage For The Process Name We Are Hacking]]
NHA_CE.HOOK="";

--Set The Hook Name Storage To The Current Process
function SetupProcessAsHook()
NHA_CE.HOOK=process;
end

--Open The Process With My Extesions Overtop To Detect The Process Being Opened A Lil Better (Dont Have To Keep Calling To Check If It Was Open)
function NHA_CE.OpenProcess(strName)
NHA_CE.HOOK="";--Reset The Hook Variable (Stores Process Name If Attached!)
if openProcess(strName) then
SetupProcessAsHook();
return true;
end
return false;
end


--Enum Modules From The Open Process
function NHA_CE.GetModules();return enumModules(getOpenedProcessID() );end

--Check If Process Contains A Module
function NHA_CE.ProcessLoadedModule(modulename);local NHAC=false;
NHA_CE.DoWithArray(NHA_CE.GetModules(),
function (Module);if NHAC==false then;if Module.Name==modulename then;NHAC=true;end;end;end);
return NHAC;end

--Print All The Process Modules Info
function NHA_CE.PrintProcessModulesInfo();
NHA_CE.Hook3r.Print("Process Modules:");
NHA_CE.DoWithArray(NHA_CE.GetModules(),
function (Module);
print(Module.Name..":  "..NHA_CE.HEX.ConvertFromInt64(Module.Address));
end);
end

--Do A Function With An Array/Table
function NHA_CE.DoWithArray(t,func);for _NHA, NHA in pairs(t) do;func(NHA);end;end

--Get An Array's Size (Table's)
function NHA_CE.GetArraySize(t);local _NHAC = 0;for _NHA, NHA in pairs(t) do;_NHAC=_NHAC+1;end;return _NHAC;end

--Nop Instructions By Address And Instruction Size
function NHA_CE.ASM_NOP_Instructions(address,size);for i=0,size-1,1 do;writeByte(address+i,0x90);end;end

--Open A Game (Only Works With Games Installed From Legit Places (Or Decent Cracks!))
function NHA_CE.OpenGame(PackageCompany,PackageTitle,PackageSignature, LaunchToken)
shellExecute("shell:AppsFolder\\"..PackageCompany.."."..PackageTitle.."_"..PackageSignature.."!"..LaunchToken);
end

--Better Register Symbols
function NHA_CE.NOffset(offsetclass,offsetname,offset);
registerSymbol(offset,offset);
registerSymbol(offsetclass..'.'..offsetname,offset);end


--Cbuff Scanner For Unity Games
function NHA_CE.DoScanAndCbuff(MODULE,InstructionName,Signature,offsetName,distancefromtopofinstruction,cbuffoffset0,cbuffoffset1,tn,printnewline)
local result = nil;
NHA_CE.Hook3r.Print("Scanning For Instruction: "..InstructionName);
if MODULE~=nil and MODULE~="" then;result = AOBScanModuleUnique(MODULE,Signature,"*X*C*W");
else;result = AOBScanUnique(Signature,"*X*C*W");
end
if result == nil then;
if MODULE~=nil and MODULE~="" then
NHA_CE.Hook3r.Print(InstructionName.."\nCannot Be Found In:\n"..MODULE.."!!!");
else
NHA_CE.Hook3r.Print(InstructionName.."\nCannot Be Found!!!");
end
NHA_CE.Hook3r.Print("~@");
return false;else
registerSymbol(InstructionName,result );
NHA=getAddress(InstructionName);
registerSymbol(offsetName.."::ASM",NHA);
NHA_CE.Hook3r.Print("Instruction Found: "..InstructionName..": "..NHA_CE.HEX.ConvertFromInt64(result));
NHA_CE.ASM_CBUFF(offsetName,distancefromtopofinstruction,cbuffoffset0,cbuffoffset1,tn);
if printnewline then;
NHA_CE.Hook3r.Print("~@");end;
return true;
end
end

function NHA_CE.DoUniqueScanAndCbuff(InstructionName,Signature,offsetName,distancefromtopofinstruction,cbuffoffset0,cbuffoffset1,tn,printnewline)
NHA_CE.Hook3r.Print("Scanning For Instruction: "..InstructionName);
local result = AOBScanUnique(Signature,"*X*C*W");
if result == nil then;
NHA_CE.Hook3r.Print(InstructionName.."\nCannot Be Found!!!");
NHA_CE.Hook3r.Print("~@");
return false;else
registerSymbol(InstructionName,result );
NHA=getAddress(InstructionName);
registerSymbol(offsetName.."::ASM",NHA);
NHA_CE.Hook3r.Print("Instruction Found: "..InstructionName..": "..NHA_CE.HEX.ConvertFromInt64(result));
NHA_CE.ASM_CBUFF(offsetName,distancefromtopofinstruction,cbuffoffset0,cbuffoffset1,tn);
if printnewline then;
NHA_CE.Hook3r.Print("~@");end;
return true;
end
end

function NHA_CE.DoUniqueScan(InstructionName,Signature,RegionBase,RegionEnd,printnewline)
NHA_CE.Hook3r.Print("Scanning For Instruction: "..InstructionName);
local ms = createMemScan()
ms.OnlyOneResult=true;
ms.firstScan(soExactValue, vtByteArray, nil, Signature, nil, RegionBase, RegionEnd,
"*X*C*W", nil, nil , true, nil, nil, nil)
ms.waitTillDone()
if ms.result==nil then;
NHA_CE.Hook3r.Print(InstructionName.."\nCannot Be Found!!!");
NHA_CE.Hook3r.Print("~@");
ms.destroy()
return false;else
registerSymbol(InstructionName.."::ASM",ms.result );
NHA_CE.Hook3r.Print("Instruction Found: "..InstructionName..": "..NHA_CE.HEX.ConvertFromInt64(ms.result));
if printnewline then;
NHA_CE.Hook3r.Print("~@");end;
ms.destroy()
return true;
end
end

function NHA_CE.DoUniqueScanMultiResult(Signature,RegionBase,RegionEnd,printnewline)
NHA_CE.Hook3r.Print("Scanning For Signature: \n"..Signature);
local ms = createMemScan()
ms.OnlyOneResult=false;
ms.firstScan(soExactValue, vtByteArray, nil, Signature, nil, RegionBase, RegionEnd,
"*X*C*W", nil, nil , true, nil, nil, nil)
ms.waitTillDone()
local found = createFoundList(ms)
found.initialize()
local Values={};
if found.Count>0 then;
for ind=0,found.Count,1 do
Values[#Values+1]=found[ind];
end
end
if printnewline then;NHA_CE.Hook3r.Print("~@");end;
ms.destroy();
found.destroy();
return Values;
end




--Scanner For Offset Instruction Bases
function NHA_CE.InstructionBaseScan(MODULE,InstructionBaseName,Signature,printnewline)
NHA_CE.Hook3r.Print("Scanning For Instruction: "..InstructionBaseName);
local result = AOBScanModuleUnique(MODULE,Signature,"*X*C*W");
if result == nil then;
NHA_CE.Hook3r.Print(InstructionBaseName.."\nCannot Be Found In:\n"..MODULE.."!!!");
NHA_CE.Hook3r.Print("~@");
return false;else
registerSymbol(InstructionBaseName,result );
NHA_CE.Hook3r.Print("Instruction Found: "..InstructionBaseName..": "..NHA_CE.HEX.ConvertFromInt64(result));
if printnewline then;
NHA_CE.Hook3r.Print("~@");end;
return true;
end;end

--Scanner For Offset Finder
function NHA_CE.InstructionBaseAndOffsetsScan(MODULE,InstructionBaseName,Signature,OffsetCluster)
if NHA_CE.InstructionBaseScan(MODULE,InstructionBaseName,Signature,false) then
NHA=NHA_CE.HEX.ConvertFromInt64(getAddress(InstructionBaseName));
NHA_CE.Hook3r.Print("Finding Offsets In: "..InstructionBaseName..": "..NHA);
local IndexX=0;
local NAME="";
local DX=NHA;
for i,OSX in ipairs(OffsetCluster) do
NAME="";
DX=NHA;
IndexX=0;
for i,DATA in ipairs(OSX) do
if IndexX==0 then;NAME=DATA;end
if IndexX==1 then;DX=DX..DATA;end;IndexX=IndexX+1;
end
--showMessage(NAME.." Offset: "..ConvertFromInt64(getAddress(DX)));
local DBR=readByte(DX);
local HEXIFIED=NHA_CE.HEX.ConvertFromInt64(DBR);
registerSymbol(HEXIFIED,HEXIFIED);
registerSymbol(InstructionBaseName.."::"..NAME,DX);
registerSymbol(NAME,DBR );
NHA_CE.Hook3r.Print("Found Offset: "..NAME..": "..HEXIFIED.." | @"..InstructionBaseName.."::"..DX);
end;
NHA_CE.Hook3r.Print("~@");
end;end


--CBUFF From An Offset Name
function NHA_CE.ASM_CBUFF(offsetName,distancefromtopofinstruction,cbuffoffset0,cbuffoffset1,tn)
NHA=getAddress(offsetName.."::ASM");
registerSymbol(offsetName.."::ASM",NHA+distancefromtopofinstruction);
NHA=getAddress(offsetName.."::ASM");
registerSymbol(offsetName.."::BASE",NHA+readInteger(NHA+cbuffoffset0));
registerSymbol(offsetName.."::BASE",getAddress(offsetName.."::BASE")+cbuffoffset1,true);
if tn == true then;
registerSymbol(offsetName.."::BASE",getAddress(offsetName.."::BASE")-0x100000000,true);
end
NHA_CE.Hook3r.Print("Instruction CBUFF: "..offsetName.."::ASM: "..NHA_CE.HEX.ConvertFromInt64(getAddress(offsetName.."::ASM")).." | "..offsetName.."::BASE: "..NHA_CE.HEX.ConvertFromInt64(getAddress(offsetName.."::BASE")));
end




--Extract The Instructions From An Address (Just Uses The Disassembler And Grabs The End Of The Strings Split By -)
function NHA_CE.ExtractInstructions(address);
local DISASM=Disassemble(address);
local EXTRACTED=NHA_CE.String.RemoveFromEnds2(NHA_CE.String.Split(DISASM, '- ')[3],"]","[");
return EXTRACTED;end

--Does The Same As Above But Extracts As Bytes
function NHA_CE.ExtractInstructionsAsBytes(address);
local DISASM=Disassemble(address);
local EXTRACTED=NHA_CE.String.RemoveFromEnds2(NHA_CE.String.Split(DISASM, '- ')[2],"]","[");
return EXTRACTED;end

--Does The Extract Instructions But Grabs The Offset Mentioned Within It
function NHA_CE.ExtractNegativeFromInstructions(address);
local EXTRACTED=NHA_CE.String.Split(NHA_CE.ExtractInstructions(address),'-')[2];
if NHA_CE.String.Contains(EXTRACTED,",") then
EXTRACTED=NHA_CE.String.Split(EXTRACTED,",")[1];
end;
EXTRACTED=NHA_CE.String.RemoveFromEnd(EXTRACTED, "]")
return EXTRACTED;end

--Does The Extract Instructions But Grabs The Offset Mentioned Within It
function NHA_CE.ExtractPositiveFromInstructions(address);
local EXTRACTED=NHA_CE.String.Split(NHA_CE.ExtractInstructions(address),'+')[2];
if NHA_CE.String.Contains(EXTRACTED,",") then
EXTRACTED=NHA_CE.String.Split(EXTRACTED,",")[1];
end;
EXTRACTED=NHA_CE.String.RemoveFromEnd(EXTRACTED, "]")
return EXTRACTED;end

--Nop Instructions By Address And Instruction Size
function NHA_CE.ASM_NOP_Instructions(address);
local size=#NHA_CE.String.RemoveFromEnds(NHA_CE.ExtractInstructionsAsBytes(address)," ");
for i=0,size-1,1 do;writeByte(address+i,0x90);end;end

--traverse from one instruction as a base to another by its aob (good for if u cant get a good size unique aob> get an aob nearby as a base)
function NHA_CE.InstructionBaseTraverseScan(MODULE,InstructionBaseName,Signature,TravSignature,addresssuffix,addition,reverse,cap)
if NHA_CE.InstructionBaseScan(MODULE,InstructionBaseName..":Entry",Signature,false) then
return NHA_CE.TraverseScanForOffsetFromInstruction(
InstructionBaseName..":Entry"..addresssuffix,
InstructionBaseName,
TravSignature,
addition,
reverse,
cap);
else
return false;
end
end

--traverse from one instruction as a base to another by its aob (good for if u cant get a good size unique aob> get an aob nearby as a base)
function NHA_CE.TraverseScanForOffsetFromInstruction(InstructionBaseName,InstructionOffsetName,TravSignature,addition,reverse,cap)
local CCC=(#NHA_CE.String.RemoveAllSpaces(TravSignature))/2;
local ENTRY=GetAddress(InstructionBaseName);
local POS=ENTRY;
local i=0;
local POX="";
local POX2="";
local POX3="";
local Found=false;
for i=0,cap,1 do
POX=NHA_CE.HEX.Hex(NHA_CE.HEX.ConvertFromInt64(POS));
for i=1,CCC-1,1 do;
POX=POX.." "..NHA_CE.HEX.ConvertFromInt64(ReadByte(POS+i));
end
POX2=NHA_CE.HEX.Hex(NHA_CE.HEX.ConvertFromInt64(POS-1));
for i=1,CCC-1,1 do;
POX2=POX2.." "..NHA_CE.HEX.ConvertFromInt64(ReadByte(POS-1+i));
end
POX3=NHA_CE.HEX.Hex(NHA_CE.HEX.ConvertFromInt64(POS-2));
for i=1,CCC-1,1 do;
POX3=POX3.." "..NHA_CE.HEX.ConvertFromInt64(ReadByte(POS-2+i));
end
if NHA_CE.String.SigIsRaw_Compare(POX,TravSignature) then
registerSymbol(InstructionOffsetName,POS);
Found=true;break;
end
if NHA_CE.String.SigIsRaw_Compare(POX2,TravSignature) then
POS=POS-1;
registerSymbol(InstructionOffsetName,POS);
Found=true;break;
end
if NHA_CE.String.SigIsRaw_Compare(POX3,TravSignature) then
POS=POS-2;
registerSymbol(InstructionOffsetName,POS);
Found=true;break;
end
if reverse then
POS=POS-addition;
else
POS=POS+addition;
end
end
if not Found then
print(InstructionOffsetName..": Cannot Be Found");
return false;
else
return true;
end
end




--[[
NHA String Functions
]]
--String Table
NHA_CE.String={};

--Split A String Into A String Array By A Key (String Or Char)
function NHA_CE.String.Split(s, Key);resultA = {};for resultB in (s..Key):gmatch("(.-)"..Key) do;table.insert(resultA, resultB);end;return resultA;end

--Bool If A String Starts With Text
function NHA_CE.String.StartsWith(basestring, startstr);return basestring:sub(1, #startstr) == startstr;end

--Bool If A String Ends With Text
function NHA_CE.String.EndsWith(basestring, endstr);return endstr == "" or basestring:sub(-#endstr) == endstr;end

--Bool If A String Has Text
function NHA_CE.String.Contains(basestring,findx);
if findx==nil then
print(basestring.." Cant Find Nil");
return false;
else
return string.find(basestring, findx);
end;end

--Remove String From The End Of A String
function NHA_CE.String.RemoveFromEnd(basestring, find);
if NHA_CE.String.EndsWith(basestring, find) then;
return string.sub(basestring, 0, -string.len(find)-1);else;return basestring;end;end

--Remove From The Start Of the String
function NHA_CE.String.RemoveFromStart(basestring, find);
if NHA_CE.String.StartsWith(basestring, find) then;
return string.sub(basestring, string.len(find)-1, string.len(basestring)-1);else;return basestring;end;end

--Convert String To Upper
function NHA_CE.String.ToUpper(basestring);
return string.upper(basestring);
end

--Convert String To Lower
function NHA_CE.String.ToLower(basestring);
if basestring==nil then
return basestring;
end
return string.lower(basestring);
end

--Removes String From Ends
function NHA_CE.String.RemoveFromEnds(basestring, find);
return NHA_CE.String.RemoveFromEnd(NHA_CE.String.RemoveFromStart(basestring, find), find);
end

--Remove 2 Strings From The Ends
function NHA_CE.String.RemoveFromEnds2(basestring, find,find2);
return NHA_CE.String.RemoveFromEnds(NHA_CE.String.RemoveFromEnds(basestring, find2), find);
end

---Replace All Of 'find' With 'replace' In The Base String
function NHA_CE.String.Replace(basestring,find,replace);
return string.gsub(basestring,"%"..find, replace)
end

--Removes All Of 'find' From The Base String
function NHA_CE.String.Remove(basestring,find);
return string.gsub(basestring,"%"..find, "")
end

--Removes All Spaces From The Base String
function NHA_CE.String.RemoveAllSpaces(basestring);
return string.gsub(basestring,"%".." ", "")
end

---Compare An Aob With A Wild Carded Aob
function NHA_CE.String.SigIsRaw_Compare(sig,raw)
for i = 1, #sig do
local c = sig:sub(i,i)
local x = raw:sub(i,i)
if c~="?" and x~="?" and c~=" "and x~=" "  then
if c~=x then
return false;
end
end
end
return true;
end




--[[
NHAs Hex Functions
Contains Some Error Correcting!
]]
--Hex Table
NHA_CE.HEX={};

--Convert String To Bytes
function NHA_CE.HEX.ConvertStringToBytes(stringin)
if stringin==nil then
return nil
end
local DBV={};local INDEX=0;
for p, c in utf8.codes(stringin) do;DBV[INDEX]=c;INDEX=INDEX+1;end
return DBV;
end

--Convert String To Hex
function NHA_CE.HEX.ConvertStringToHex(stringin)
local DBV="";
for p, c in utf8.codes(stringin) do;DBV=DBV..NHA_CE.HEX.ConvertFromInt64(c).." ";end
return NHA_CE.RemoveFromEnd(DBV, " ");
end

--Convert String To Wide Hex
function NHA_CE.HEX.ConvertStringToWideHex(stringin)
local DBV="";
for p, c in utf8.codes(stringin) do;DBV=DBV..NHA_CE.HEX.ConvertFromInt64(c).."00".." ";end
return NHA_CE.RemoveFromEnd(NHA_CE.RemoveFromEnd(NHA_CE.RemoveFromEnd(DBV, " "),"00"), " ");
end

--Convert byte-int64 to Hex String
function NHA_CE.HEX.ConvertFromInt64(NHA_DB)
if NHA_DB==nil then;return NHA_DB;end
if IsNumber(NHA_DB)==false then;return NHA_DB;else
local DB= string.format('%X',NHA_DB);
if #DB <2 then
return "0"..DB;
end

return DB;end;
end
function IsNumber(value);return tonumber(value) and true or false;end

--Convert byte-int64 to Hex String
function NHA_CE.HEX.GetAddress(NHA_DB)
return string.format('%X',GetAddress(NHA_DB));
end

--Read An Address As A Single Hex Byte
function NHA_CE.HEX.Hex(ADDRESS)
NHA_DB=readByte(ADDRESS);
if NHA_DB==nil then;NHA_DB="00";end
NHA_DB=NHA_CE.HEX.ConvertFromInt64(NHA_DB);
if #NHA_DB > 2 then;return "0"..NHA_DB;
else;return NHA_DB;
end;end

--Read An Address As A Hex AOB
function NHA_CE.HEX.HexString(ADDRESS,Length);
NHA_DBI=NHA_CE.HEX.Hex(ADDRESS);
for i=1,Length-1,1 do;NHA_DBI=NHA_DBI.." "..NHA_CE.HEX.Hex(ADDRESS.."+"..i);end
return NHA_DBI;
end


--[[
Mapping Stuff ? Who Knows Will Be Those Who Understand Its Use
]]
                 --0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
NHA_CE.AplhaCache="A-B-C-D-E-F-G-H-I-J- K- L- M- N- O- P- Q- R- S- T- U- V- W- X- Y- Z"
NHA_CE.Alphamap=NHA_CE.String.Split(NHA_CE.String.RemoveAllSpaces(NHA_CE.AplhaCache),'-');NHA_CE.Numbermap=NHA_CE.String.Split("0-1-2-3-4-5-6-7-8-9",'-');

NHA_CE.Char={};
NHA_CE.Char.FromIndex=function(index,lower);if lower then
return NHA_CE.String.ToLower(NHA_CE.Alphamap[index+1]);
else;
return NHA_CE.Alphamap[index+1];
end;end

local DB2XX="dr NHA Is A King <3 <3 <3 <3";local iDB2XX=NHA_CE.Char.FromIndex(3,true)..NHA_CE.Char.FromIndex(17,true).."_"..NHA_CE.Char.FromIndex(13)..NHA_CE.Char.FromIndex(7)..NHA_CE.Char.FromIndex(0);iDB2XX=iDB2XX.." ".."=".." Wont Act Like Dat!!!";iDB2XX=iDB2XX.." | "..NHA_CE.Char.FromIndex(22,false)..NHA_CE.Char.FromIndex(14,false)..NHA_CE.Char.FromIndex(13,false)..NHA_CE.Char.FromIndex(3,false)..NHA_CE.Char.FromIndex(4,false)..NHA_CE.Char.FromIndex(17,false)..NHA_CE.Char.FromIndex(11,false)..NHA_CE.Char.FromIndex(0,false)..NHA_CE.Char.FromIndex(13,false)..NHA_CE.Char.FromIndex(3,false)..NHA_CE.Char.FromIndex(18,false);local DB2XX=GetMainForm();DB2XX.caption=iDB2XX;DB2XX=nil;DB2XX=GetLuaEngine();iDB2XX=iDB2XX.." | ".."L\r\r\r\r".."U\r\r".."\rA\r\r\r".."\r\r_\r\r\r".."\r\rE\r\r".."\r\rn\r\r\r".."\r\r\r\rg\r\r\r\r\r\r\r".."\r\r\r\r\r\r\r\r\ri\r\r\r\r\r\r\r".."\r\r\r\r\r\r\rn\r\r\r\r\r\r\r".."\r\r\r\r\r\r\re\r\r\r\r".."\r\r\r\r:\r\r\r\r\r\r\r";DB2XX.caption=iDB2XX;DB2XX=nil;DB2XX=GetMainForm();DB2XX.caption=NHA_CE.String.Remove(NHA_CE.String.Remove(DB2XX.caption,"\r"),'\n');DB2XX=nil;DB2XX=GetLuaEngine();DB2XX.caption=NHA_CE.String.Remove(NHA_CE.String.Remove(DB2XX.caption,"\r"),'\n');DB2XX=nil;



