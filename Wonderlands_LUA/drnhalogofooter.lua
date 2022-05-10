AuthorName = AuthorName or 'dr-NHA'
AuthorHint = AuthorHint or ''
TablePostUrl = TablePostUrl or [[https://github.com/dr-NHA/Wonderlands]]
FooterLogoFileName = FooterLogoFileName or 'drnhalogo.png'
AddLicenseLabel = AddLicenseLabel or false
LicenseName = LicenseName or 'NHA'
LicenseHint=LicenseHint or 'NHA'
TrainerInfoAndHelp = TrainerInfoAndHelp or 'TrainerInfo.txt'

if FooterAdded then return end
local tableFile = findTableFile(FooterLogoFileName)
if tableFile then
----
NHA_BOTTOMBAR = createPanel(AddressList)
local pic = createPicture()
pic.loadFromStream(tableFile.Stream)
local bitmap = pic.getBitmap()
----
local collapsible=false;

local splitter
if collapsible then
splitter = createSplitter(AddressList)
splitter.Align = alBottom
splitter.Height = 5
splitter.MinSize = 50 --standardize with MainForm.Splitter1.MinSize

local splitterDblClick = false
splitter.onMoved = function(sender)
--set new NHA_BOTTOMBAR height if double click flag has not yet expire
if splitterDblClick then
if NHA_BOTTOMBAR.Height == 1 then --open NHA_BOTTOMBAR if closed
NHA_BOTTOMBAR.Height = bitmap.Height
else --close NHA_BOTTOMBAR if opened
NHA_BOTTOMBAR.Height = 1
end
--refresh NHA_BOTTOMBAR position else it bugs out and appear underneath bottom bar
NHA_BOTTOMBAR.Top = 0
splitter.Top = 0
else
splitterDblClick = true
local dblClickInterval = createTimer()
dblClickInterval.Interval = 500
dblClickInterval.OnTimer = function () --reset double click flag after double click interval
splitterDblClick = false
dblClickInterval.destroy()
end
end
end
end
---
NHA_BOTTOMBAR.width = 10
NHA_BOTTOMBAR.top = 0
NHA_BOTTOMBAR.left = 10
NHA_BOTTOMBAR.Height = bitmap.Height
NHA_BOTTOMBAR.Align = alBottom
NHA_BOTTOMBAR.Anchors = '[akBottom]'
-- NHA_BOTTOMBAR.Color = AddressList.getComponent(0).Color
NHA_BOTTOMBAR.ParentBackground = true
NHA_BOTTOMBAR.BorderStyle = bsSingle
NHA_BOTTOMBAR.BevelOuter = bvNone
-- NHA_BOTTOMBAR.BevelColor = clBlack
NHA_BOTTOMBAR.Constraints.MaxHeight = bitmap.Height
NHA_BOTTOMBAR.ShowHint = true
NHA_BOTTOMBAR.Hint = 'Double Click To Open Discord Invite'
NHA_BOTTOMBAR.onDblClick = function(sender)
shellExecute([[https://github.com/dr-NHA/Wonderlands/blob/NHA_Wonderlands/Discord]])
end
local authLabel = createLabel(NHA_BOTTOMBAR)
authLabel.Top = 2
authLabel.Caption = AuthorName
authLabel.Font.Name = 'Lucida Console'
authLabel.Font.Color = 0xFFFFFF
authLabel.Font.Style = '[fsBold]'
authLabel.ShowHint = true
authLabel.Hint = AuthorHint
authLabel.Cursor = crHandPoint
authLabel.onDblClick = function(sender)
shellExecute(TablePostUrl)
end
local licLabel
if AddLicenseLabel then
licLabel = createLabel(NHA_BOTTOMBAR)
licLabel.Top = 2
licLabel.Caption = LicenseName
licLabel.Font.Name = 'Lucida Console'
licLabel.Font.Size = 8
licLabel.Font.Color = 0xFFFFFF
licLabel.ShowHint = true
licLabel.Hint = LicenseHint
licLabel.Cursor = crHandPoint
licLabel.onDblClick = function(sender)
local tf = findTableFile(TrainerInfoAndHelp)
if tf then
local stream = tf.getData()
if stream then
local fileStr = readStringLocal(stream.memory, stream.size)
GetLuaEngine().MenuItem5.doClick()
print(fileStr)
end
end
end
end
NHA_BOTTOMBAR.onPaint = function(sender)
local cannvas = sender.getCanvas()
local left = (NHA_BOTTOMBAR.Width / 2) - (bitmap.Width / 2)
cannvas.draw(left, 0, bitmap)
authLabel.Left = left + 72
-- if licLabel then
-- licLabel.Left = authLabel.Left + authLabel.Width + 16
-- end
if licLabel then
licLabel.Left = (bitmap.Width - licLabel.Width) + left
end
end
----
if splitter then
NHA_BOTTOMBAR.Top = 0
splitter.Top = 0
end
----
FooterAdded = true
end