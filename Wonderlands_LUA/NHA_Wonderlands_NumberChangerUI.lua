

--[[
    Number Changer UI
]]
Wonderlands.NumberChangerFunc=function(VALUE)
print("The Number Changed Needs To Be Setup!\nValue: "..VALUE);
end
Wonderlands.NumberChangerClosedFunc=function()
print("Closed The Number Changer BUTT The Number Changed Needs To Be Setup! ");
end

Wonderlands.NumberChangerValueWasSet=false;
function NumberChangeWindow_NumberSetClick(sender)
Wonderlands.NumberChangerValueWasSet=true;
Wonderlands.NumberChangerFunc(Wonderlands.GetNumberChangerValue());
NumberChangeWindow.Close();
end

function NumberChangeWindow_FormClose(sender)
if Wonderlands.NumberChangerValueWasSet==false then
Wonderlands.NumberChangerClosedFunc();
end
return caHide --Possible options: caHide, caFree, caMinimize, caNone
end



function Wonderlands.GetNumberChangerValue()
return NumberChangeWindow.NumberBox.getCaption();
end

function Wonderlands.SetNumberChangerValue(Value)
NumberChangeWindow.NumberBox.setCaption(Value);
end

function NumberChangeWindow_NumberBoxKeyUp(sender, key)
local NUMBER=tonumber(Wonderlands.GetNumberChangerValue());
if NUMBER<Wonderlands.NumberChangerMinimum then
Wonderlands.SetNumberChangerValue(Wonderlands.NumberChangerMinimum);
elseif NUMBER>Wonderlands.NumberChangerMaximum then
Wonderlands.SetNumberChangerValue(Wonderlands.NumberChangerMaximum);
end
return key
end


Wonderlands.NumberChangerMinimum=0;
Wonderlands.NumberChangerMaximum=20;

function Wonderlands.OpenNumberChanger(HelpText,StartValue,Minimum,Maximum,Action,ClosedWithoutSettingAction)
Wonderlands.NumberChangerValueWasSet=false;
Wonderlands.NumberChangerMinimum=Minimum;
Wonderlands.NumberChangerMaximum=Maximum;
Wonderlands.SetNumberChangerValue(StartValue);
NumberChangeWindow.Help.setCaption(HelpText);
Wonderlands.NumberChangerFunc=Action;
Wonderlands.NumberChangerClosedFunc=ClosedWithoutSettingAction;
NumberChangeWindow.centerScreen();
 FixSyncIssue(function()
NumberChangeWindow.showModal();
 end,10);

end



function TEST()
Wonderlands.OpenNumberChanger(
"Help Text Goes HERE!",--[[Help Text / Label Text]]
69--[[Current]],
0--[[Minimum]],
2000--[[Maximum]],
function(VALUE)--Value Set And Closed
print("Test Value: "..VALUE);
end,
function()--User Closed Without Setting Value
print("Closed The Test Window!");
end);
end

