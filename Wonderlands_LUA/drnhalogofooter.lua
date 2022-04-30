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
local panel = createPanel(AddressList)
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
--set new panel height if double click flag has not yet expire
if splitterDblClick then
if panel.Height == 1 then --open panel if closed
panel.Height = bitmap.Height
else --close panel if opened
panel.Height = 1
end
--refresh panel position else it bugs out and appear underneath bottom bar
panel.Top = 0
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
panel.width = 10
panel.top = 0
panel.left = 10
panel.Height = bitmap.Height
panel.Align = alBottom
panel.Anchors = '[akBottom]'
-- panel.Color = AddressList.getComponent(0).Color
panel.ParentBackground = true
panel.BorderStyle = bsSingle
panel.BevelOuter = bvNone
-- panel.BevelColor = clBlack
panel.Constraints.MaxHeight = bitmap.Height
panel.ShowHint = true
panel.Hint = 'Double Click To Open Discord Invite'
panel.onDblClick = function(sender)
shellExecute([[https://github.com/dr-NHA/Wonderlands/blob/NHA_Wonderlands/Discord]])
end
local authLabel = createLabel(panel)
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
licLabel = createLabel(panel)
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
panel.onPaint = function(sender)
local cannvas = sender.getCanvas()
local left = (panel.Width / 2) - (bitmap.Width / 2)
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
panel.Top = 0
splitter.Top = 0
end
----
FooterAdded = true
end
