

--[[

The Storage Directory For The Game
]]
local WonderlandsDirectory=[[D:\Tiny Tina Wonderlands\Tiny.Tinas.Wonderlands\Tiny.Tinas.Wonderlands\Wonderlands.exe]];
local WonderlandsHackSettingsDirectory=[[C:\test\]];

-- check if we can open the folder
local checkDir = io.open(WonderlandsHackSettingsDirectory, "r")

-- if the folder is not existing
if checkDir == nil then
-- we're making it automatically
os.execute(string.format("mkdir %s", WonderlandsHackSettingsDirectory))
end



local BinaryDirectory='\\OakGame\\Binaries\\Win64\\';--DO NOT EDIT!
local Executable='Wonderlands.exe';--DO NOT EDIT!



function GetHackSettingsFile()
return WonderlandsHackSettingsDirectory..".WonderLandsHS.NHA";
end

Wonderlands.LaunchCompleted=false;
function Wonderlands.OpenGame()
Wonderlands.LaunchCompleted=false;
print("Attempting To Launch From: \n"..WonderlandsDirectory..BinaryDirectory..Executable);



if pathExist(WonderlandsDirectory..BinaryDirectory,Executable) then
shellExecute(WonderlandsDirectory..BinaryDirectory..Executable,'-OakGame '..'-ThaDoc'..'-NHA'..'-ThaDoc'..'-DoctorEnHeichAyee'..'-NHA'..'-ThaDoc'..'-epicovt = "'..WonderlandsDirectory..'\\.egstore\\CopyingMyCrackWillNotWorkForYou\\CrackedByDrNHABeforeAnyoneElse.ovt" '..'-NHA'..'-ThaDoc'..'-ErrorAction = SilentlyContinue'..'-NHA'..'-ThaDoc'..'-DoctorEnHeichAyee'..'-NHA'..'-ThaDoc'..'-NoStartupMovies '..'-NHA'..'-ThaDoc'..'-DoctorEnHeichAyee'..'-NHA'..'-ThaDoc'..'-nosplash '..'-ThaDoc'..'-NHA'..'-ThaDoc'..'-windowed '..'-NHA'..'-ThaDoc'..'-AlwaysFocus '..'-drNHA'..'-ThaDoc'..'-PREFLIGHT_SCRIPT_WILL_REPLACE '..'-ThaDoc'..'-LAUCNHER=dr NHA'..'-ThaDoc'..'-ErrorAction = SilentlyContinue');
Wonderlands.LaunchCompleted=true;
else--Path Invalid
Wonderlands.FindGameExeDialog(true);
end;

if pathExist(WonderlandsDirectory..BinaryDirectory,Executable) then
shellExecute(WonderlandsDirectory..BinaryDirectory..Executable,'-OakGame '..'-ThaDoc'..'-NHA'..'-ThaDoc'..'-DoctorEnHeichAyee'..'-NHA'..'-ThaDoc'..'-epicovt = "'..WonderlandsDirectory..'\\.egstore\\CopyingMyCrackWillNotWorkForYou\\CrackedByDrNHABeforeAnyoneElse.ovt" '..'-NHA'..'-ThaDoc'..'-ErrorAction = SilentlyContinue'..'-NHA'..'-ThaDoc'..'-DoctorEnHeichAyee'..'-NHA'..'-ThaDoc'..'-NoStartupMovies '..'-NHA'..'-ThaDoc'..'-DoctorEnHeichAyee'..'-NHA'..'-ThaDoc'..'-nosplash '..'-ThaDoc'..'-NHA'..'-ThaDoc'..'-windowed '..'-NHA'..'-ThaDoc'..'-AlwaysFocus '..'-drNHA'..'-ThaDoc'..'-PREFLIGHT_SCRIPT_WILL_REPLACE '..'-ThaDoc'..'-LAUCNHER=dr NHA'..'-ThaDoc'..'-ErrorAction = SilentlyContinue');
Wonderlands.LaunchCompleted=true;
else--Path Invalid
Wonderlands.FindGameExeDialog(true);
end;
end


--[[
Way For Users To Locate Their Game Files
]]

function Wonderlands.FindGameExeDialog(executewhenfound)
if executewhenfound==nil then
executewhenfound=false;
end
showMessage("Please Locate Your Games EXE File!");
dialog = createOpenDialog()
dialog.caption="Please Locate Your Wonderlands .EXE";
dialog.Filename = '~Wonderlands.exe'
dialog.DefaultExt = ".exe"
dialog.Filter = "Executable (*.exe)|*.exe"
dialog.FilterIndex = 1
dialog.Options = '[ofEnableSizing]'
if dialog.execute() then
WonderlandsDirectory=NHA_CE.String.RemoveFromEnd(NHA_CE.String.RemoveFromEnd(dialog.Filename, "\\"..Executable),BinaryDirectory);
if pathExist(WonderlandsDirectory..BinaryDirectory,Executable) then
print("Exe Has Been Found In:\n"..WonderlandsDirectory)
SaveWonderlandsHackSettings();--Auto Save When The User Found Their EXE
if executewhenfound then
Wonderlands.OpenGame();
end
else--Exe Cant Be Found!
print("Exe Cant Be Found In:\n"..WonderlandsDirectory)
 end
end
end


--Writes The User Settings
function SaveWonderlandsHackSettings()
local f = assert(io.open(GetHackSettingsFile(), "w"))
f:write(WonderlandsDirectory, "\n")

f:close()
end;


--Loads The User Settings
function LoadWonderlandsHackSettings()

if pathExist(WonderlandsHackSettingsDirectory,".WonderLandsHS.NHA") then
local f = assert(io.open(GetHackSettingsFile(), "r"))
WonderlandsDirectory = f:read("*line")
WonderlandsDirectory=NHA_CE.String.RemoveFromEnd(NHA_CE.String.RemoveFromEnd(WonderlandsDirectory, "\\"..Executable),BinaryDirectory);
--print("Wonderlands Hack Settings Loaded!");
f:close()
end;

SaveWonderlandsHackSettings();--Save After Load (For Inital Settings File)
end
LoadWonderlandsHackSettings();

