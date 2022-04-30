
function GetAIBalanceState(PlayerClass)
return GetAddress('['..PlayerClass..']+2560')
end

function SetAIExperienceLevel(PlayerClass,value)
WriteInteger('['..NHA_CE.HEX.ConvertFromInt64(GetAIBalanceState(PlayerClass))..']+1A8',value)
end

function GetAIExperienceLevel(PlayerClass)
return ReadInteger('['..NHA_CE.HEX.ConvertFromInt64(GetAIBalanceState(PlayerClass))..']+1A8')
end

function SetAIGameStage(PlayerClass,value)
WriteInteger('['..NHA_CE.HEX.ConvertFromInt64(GetAIBalanceState(PlayerClass))..']+1A4',value)
end

function GetAIGameStage(PlayerClass)
return ReadInteger('['..NHA_CE.HEX.ConvertFromInt64(GetAIBalanceState(PlayerClass))..']+1A4')
end


function MaxAIExp(PlayerClass)
SetAIExperienceLevel(PlayerClass,126);
SetAIGameStage(PlayerClass,126);
end

Wonderlands.GlobalAIExpValue=126;
function SetAIExpFromStored(PlayerClass)
SetAIExperienceLevel(PlayerClass,Wonderlands.GlobalAIExpValue);
SetAIGameStage(PlayerClass,Wonderlands.GlobalAIExpValue);
end
