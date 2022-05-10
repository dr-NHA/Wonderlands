

function PlayerUI_TP_All_To_Host_Map_LocationClick(sender)
local MapXYZ=HostMapLocation();
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.Position.Value.Set(MapXYZ.X,MapXYZ.Y,MapXYZ.Z);
end);
end

function PlayerUI_TP_ToFirstSelectedClick(sender)
Players.Host.TeleportToPlayer(PlayerUI_GetFirstSelectedPlayer());
end

function PlayerUI_TP_All_To_HostClick(sender)
PlayerUI_ForeachSelectedPlayer(function(Player)
Player.TeleportToPlayer(Players.Host);
end);
end

function ReadVector3(Address)
return NewVector3(
readFloat(Address..'+0'),
readFloat(Address..'+4'),
readFloat(Address..'+8'));
end

function NewVector3(x,y,z)
local Vector3={};
Vector3.X=x;
Vector3.Y=y;
Vector3.Z=z;
return Vector3;
end


function HostMapLocation()
return ReadVector3('[[[[[[[[GEngine]+GameEngine.GameViewport]+GameViewport.World]+148]+470]+0]+118]+F38]+9B0');
end




function PlayerUI_TeleportTreeDblClick(sender)
PlayerUI_ForeachSelectedPlayer(PlayerUI_TeleportPlayerToSelectedNode);
end

local NHA_NodeSense_TeleportTree={};
function PlayerUI_TeleportPlayerToSelectedNode(Player)
if Player~=nil then
for DB=1,#NHA_NodeSense_TeleportTree,1 do
local Position=NHA_NodeSense_TeleportTree[DB]();
if Position~=nil then
Player.Position.Value.Set(Position.X,Position.Y,Position.Z);
break;
end
end
end
end


function NHA_NodeSensePlus(ParentNode,Subnodearray)
if Subnodearray[1]==nil then
for Index=2,#Subnodearray,1 do
local DBR=ParentNode.add(Subnodearray[Index][1]);
NHA_NodeSense_TeleportTree[#NHA_NodeSense_TeleportTree+1]=function(PlayerClass)
if DBR.Selected then
return Subnodearray[Index][2]();
end
return nil;
end
end
else
for Index=1,#Subnodearray,1 do
local Subbie=Subnodearray[Index];
NHA_NodeSensePlus(ParentNode.add(Subbie[1]),Subbie[2]);
end
end
end


function TeleportTreeAdd(NewNodeParent,Subnodearray)
NHA_NodeSensePlus(PlayerUI.TeleportTree.Items.add(NewNodeParent),Subnodearray)
end


PlayerUI.TeleportTree.Items.Clear();

function NamedPosition(Name,X,Y,Z)
return {Name--[[Function Name]],function();return NewVector3(X,Y,Z)end--[[Function]]};
end

TeleportTreeAdd("Loot Dice Locations",--Base Name
{{"CrackMast Cove (22)",{nil,
NamedPosition("CrackMast Cove 1",-13909.68750 , -36475.76950 , 1517.18060),
NamedPosition("CrackMast Cove 2",-13027.81930 , -20461.88280 , 0271.32250),
NamedPosition("CrackMast Cove 3",-2932.457270 , -23181.32220 , 1684.29040),
NamedPosition("CrackMast Cove 4",-1355.483760 , -18460.83980 , 0428.82910),
NamedPosition("CrackMast Cove 5",-25204.89840 , -3572.417230 , -2539.9387),
NamedPosition("CrackMast Cove 6",-13899.59370 , -8951.478510 , -1921.6959),
NamedPosition("CrackMast Cove 7",-8256.128900 , -2500.628170 , -2323.8688),
NamedPosition("CrackMast Cove 8",-18742.91990 , -25685.80460 , -1468.8579),
NamedPosition("CrackMast Cove 9",-21890.59760 , -38851.92960 , -2393.6149),
NamedPosition("CrackMast Cove 10",-8353.68750 , -35488.66400 , -1994.9427),
NamedPosition("CrackMast Cove 11",5103.674310 , -33794.01950 , -2497.0849),
NamedPosition("CrackMast Cove 12",-237.223550 , -21618.08780 , -1979.7302),
NamedPosition("CrackMast Cove 13",-2437.26660 , -1151.080440 , -1687.9317),
NamedPosition("CrackMast Cove 14",9894.114250 , -7909.388180 , -510.09732),
NamedPosition("CrackMast Cove 15",12123.29000 , -3805.833000 , 82.7723464),
NamedPosition("CrackMast Cove 16",20904.18750 , 03312.059080 , 393.565856),
NamedPosition("CrackMast Cove 17",12388.90910 , -17954.74020 , 93.0132369),
NamedPosition("CrackMast Cove 18",20798.22265 , -15777.77539 , 572.325805),
NamedPosition("CrackMast Cove 19",21797.60937 , -22394.07420 , -1086.4157),
NamedPosition("CrackMast Cove 20",29428.07421 , -26979.15039 , -1175.2363),
NamedPosition("CrackMast Cove 21",38399.19140 , -2897.625976 , -417.59020),
NamedPosition("CrackMast Cove 22",32846.83593 , 1426.3247070 , -2918.5458),

}},
{"Sunfang Oasis (15)",{nil,
NamedPosition("Sunfang Oasis 1", -37736.9414 , -2987.1162000 , -12486.2539),
NamedPosition("Sunfang Oasis 2", -70525.6171 , 02323.8730000 , -3101.44653),
NamedPosition("Sunfang Oasis 3", -60506.2968 , 906.649658203 , -4117.79736),
NamedPosition("Sunfang Oasis 4", -78105.6562 , 23474.5703125 , -8078.32660),
NamedPosition("Sunfang Oasis 5", -83750.6328 , 6250.84179687 , -6442.36572),
NamedPosition("Sunfang Oasis 6", -96168.0234 , 12686.6484375 , -8176.93115),
NamedPosition("Sunfang Oasis 7", -111161.757 , 6584.30419921 , -9589.76464),
NamedPosition("Sunfang Oasis 8", -110693.851 , 256.077301025 , -8776.10839),
NamedPosition("Sunfang Oasis 9", -121511.203 , -5122.7270507 , -12486.2539),
NamedPosition("Sunfang Oasis 10",-110537.203 , -10418.248046 , -9024.53515),
NamedPosition("Sunfang Oasis 11",-100546.960 , -17220.660156 , -8647.45800),
NamedPosition("Sunfang Oasis 12",-100247.890 , 1805.06359863 , -8722.40136),
NamedPosition("Sunfang Oasis 13",-89186.0468 , -28056.484375 , -8443.84960),
NamedPosition("Sunfang Oasis 14",-75984.5781 , -17542.625000 , -7236.54833),
NamedPosition("Sunfang Oasis 15",-66160.0234 , -17524.593750 , -5043.15429),

}},
{"Brighthoof (20)",{nil,
NamedPosition("Brighthoof 1",  -3762.7780761 , 23362.9648435 , 5763.228027),
NamedPosition("Brighthoof 2",  -11046.206054 , 13104.0810588 , 3386.469726),
NamedPosition("Brighthoof 3",  -10344.866210 , 8836.97265625 , 4144.987792),
NamedPosition("Brighthoof 4",  -16097.381835 , 7465.17285156 , 2992.687011),
NamedPosition("Brighthoof 5",  -15948.196289 , 173.387710571 , 4650.861328),
NamedPosition("Brighthoof 6",  -11884.943359 , -2512.2810058 , 4756.150878),
NamedPosition("Brighthoof 7",  -7272.4760742 , 1294.35998535 , 6363.497558),
NamedPosition("Brighthoof 8",  11263.0214840 , 12970.2763671 , 4205.310546),
NamedPosition("Brighthoof 9",  11905.7685546 , 9814.76562500 , 5409.731933),
NamedPosition("Brighthoof 10", 5056.29150390 , 9747.91015625 , 6282.738769),
NamedPosition("Brighthoof 11", 3154.07128906 , 5122.08935546 , 3926.980957),
NamedPosition("Brighthoof 12", 5213.90576171 , 4911.41259765 , 5315.535156),
NamedPosition("Brighthoof 13", 7841.84277343 , 145.453323364 , 4125.770996),
NamedPosition("Brighthoof 14", 9457.45703125 , -7129.0488281 , 4308.494140),
NamedPosition("Brighthoof 15", 2017.42016601 , 1982.36889648 , 1982.368896),
NamedPosition("Brighthoof 16", -8146.1352533 , -8450.9033203 , 3089.464111),
NamedPosition("Brighthoof 17", -9.8525276182 , -5401.8002929 , 6139.022949),
NamedPosition("Brighthoof 18", -3079.8432618 , -1137.0419921 , 5410.585449),
NamedPosition("Brighthoof 19", -1608.5599364 , 4228.54492180 , 6314.530273),
NamedPosition("Brighthoof 20", -7652.8432688 , -2707.5061035 , 5316.455566),

}},
{"Karnok's Wall (20)",{nil,
NamedPosition("Karnok's Wall 1",  -15572.3505859 , -337.064819 , 2072.27709),
NamedPosition("Karnok's Wall 2",  -30055.2421875 , -6871.13964 , 4298.40283),
NamedPosition("Karnok's Wall 3",  -17168.5664062 , -16985.0468 , 6047.50195),
NamedPosition("Karnok's Wall 4",  -7296.68115234 , 14716.24804 , 4497.61669),
NamedPosition("Karnok's Wall 5",  6018.210937500 , 22008.11523 , 6169.49560),
NamedPosition("Karnok's Wall 6",  6353.155761718 , 13821.68457 , 5269.44921),
NamedPosition("Karnok's Wall 7",  9003.284179687 , 10803.68750 , 4783.64794),
NamedPosition("Karnok's Wall 8",  12068.93261718 , 14591.10742 , 5623.34814),
NamedPosition("Karnok's Wall 9",  14440.18066406 , -3966.72070 , 3067.23168),
NamedPosition("Karnok's Wall 10", 30446.79296875 , 28435.00976 , 15300.8398),
NamedPosition("Karnok's Wall 11", 35104.33593750 , 16763.78906 , 10992.5234),
NamedPosition("Karnok's Wall 12", -1769.91662597 , 29515.25195 , 21490.6679),
NamedPosition("Karnok's Wall 13", -1173.44213867 , 12148.26953 , 24706.3261),
NamedPosition("Karnok's Wall 14", -7142.91308593 , 22916.25781 , 10748.9570),
NamedPosition("Karnok's Wall 15", -1029.69384765 , 23360.90429 , 11215.9638),
NamedPosition("Karnok's Wall 16", 5936.729492187 , -21460.1542 , 9278.86035),
NamedPosition("Karnok's Wall 17", -3468.65551757 , 17340.41210 , 7299.11181),
NamedPosition("Karnok's Wall 18", -29981.6679687 , 9640.662109 , 12261.3242),
NamedPosition("Karnok's Wall 19", -13019.7373046 , 17412.37109 , 12481.7060),
NamedPosition("Karnok's Wall 20", -21948.9140625 , 11781.62500 , 10304.5136),

}},
{"Overworld (22)",{nil,
NamedPosition("Overworld 1",  10974.636715 , 1571.6829833 , 1928.87915039),
NamedPosition("Overworld 2",  18945.173825 , 2392.1003417 , 1791.44702148),
NamedPosition("Overworld 3",  -8818.609375 , -289.4955444 , 391.118621826),
NamedPosition("Overworld 4",  -11862.11428 , -6970.136710 , 1280.88000488),
NamedPosition("Overworld 5",  -9687.973632 , -14941.57510 , 976.979370117),
NamedPosition("Overworld 6",  -4498.140136 , -18516.08390 , 983.770019531),
NamedPosition("Overworld 7",  1365.2150878 , -17205.88470 , -373.89477533),
NamedPosition("Overworld 8",  3095.7995605 , -24323.54100 , -734.71386710),
NamedPosition("Overworld 9",  16337.416992 , -24606.33000 , -604.38903804),
NamedPosition("Overworld 10", 5281.0292968 , -30377.28510 , -1130.3015139),
NamedPosition("Overworld 11", 18962.326171 , -32971.01950 , -1849.2471928),
NamedPosition("Overworld 12", 14631.059570 , -36987.69920 , -2017.0062259),
NamedPosition("Overworld 13", 19972.154296 , -39869.12890 , -1345.3330025),
NamedPosition("Overworld 14", 17374.093750 , -43843.24210 , -426.02810945),
NamedPosition("Overworld 15", 7024.9125976 , -37213.85930 , -1756.0942813),
NamedPosition("Overworld 16", 7089.8647460 , -41756.81640 , -662.46032844),
NamedPosition("Overworld 17", -1988.545898 , -42981.85930 , 801.607543531),
NamedPosition("Overworld 18", -3940.185302 , -54923.08980 , 1258.97668703),
NamedPosition("Overworld 19", -9476.421875 , -61421.80070 , 1289.92009453),
NamedPosition("Overworld 20", -3111.716060 , -59992.79680 , 1885.60420469),
NamedPosition("Overworld 21", 6413.9082030 , -54095.50780 , 3035.57544531),
NamedPosition("Overworld 22", 19733.826170 , -49946.61710 , 2088.72336719),

}},
{"Fearamid (9)",{nil,
NamedPosition("Fearamid 1",13092.919921875 ,9667.4521484375 ,43334.1484375),
NamedPosition("Fearamid 2",3436.8630371094 ,-7678.28125 ,37589.0078125),
NamedPosition("Fearamid 3",-7192.9291992188 ,2453.1374511719 ,36787.16015625),
NamedPosition("Fearamid 4",-900.10076904297 ,-207.25177001953 ,36844.2734375),
NamedPosition("Fearamid 5",-729.68927001953 ,7301.802734375 ,36686.32421875),
NamedPosition("Fearamid 6",5784.7333984375 ,10079.361328125 ,34074.4140625),
NamedPosition("Fearamid 7",1740.9008789063 ,9787.1923828125 ,40307.1484375),
NamedPosition("Fearamid 8",4826.783203125 ,14448.088867188 ,38710.0234375),
NamedPosition("Fearamid 9",5195.1479492188 ,18040.947265625 ,39710.3828125),

}},
{"Shattergrave Barrow (12)",{nil,
NamedPosition("Shattergrave Barrow 1",-58603.50390625 ,770.64849853516 ,1196.8109130859),
NamedPosition("Shattergrave Barrow 2",-50748.3046875 ,4233.044921875 ,1356.7403564453),
NamedPosition("Shattergrave Barrow 3",-42343.6171875 ,-5550.6137695313 ,440.94003295898),
NamedPosition("Shattergrave Barrow 4",-29151.677734375 ,-17703.38671875 ,713.32458496094),
NamedPosition("Shattergrave Barrow 5",-23044.548828125 ,-9789.6982421875 ,304.95141601563),
NamedPosition("Shattergrave Barrow 6",-2026.5958251953 ,-7728.0024414063 ,1962.6499023438),
NamedPosition("Shattergrave Barrow 7",3022.0502929688 ,-15904.607421875 ,2267.0903320313),
NamedPosition("Shattergrave Barrow 8",-518.49462890625 ,-14133.211914063 ,2031.1391601563),
NamedPosition("Shattergrave Barrow 9",-1067.1527099609 ,-7569.3149414063 ,2593.8132324219),
NamedPosition("Shattergrave Barrow 10",7788.83203125 ,-8806.666015625 ,3318.8977050781),
NamedPosition("Shattergrave Barrow 11",10445.931640625 ,-8625.0947265625 ,610.59552001953),
NamedPosition("Shattergrave Barrow 12",17921.0078125 ,-5134.876953125 ,536.64154052734),

}},
{"Queen's Gate (15)",{nil,
NamedPosition("Queen's Gate 1",-25717.845703125 ,-33934.01171875 ,-2457.2595214844),
NamedPosition("Queen's Gate 2",-24643.26171875 ,-25231.353515625 ,-1664.2489013672),
NamedPosition("Queen's Gate 3",-36598.5625 ,-15305.7890625 ,-1231.9422607422),
NamedPosition("Queen's Gate 4",-33133.984375 ,-9221.7041015625 ,-483.78298950195),
NamedPosition("Queen's Gate 5",-29459.7890625 ,-6972.9877929688 ,-411.67568969727),
NamedPosition("Queen's Gate 6",-21916.423828125 ,-7361.8237304688 ,-110.66672515869),
NamedPosition("Queen's Gate 7",-16994.6484375 ,-1157.5471191406 ,248.05674743652),
NamedPosition("Queen's Gate 8",-7584.1171875 ,19099.39453125 ,-477.22775268555),
NamedPosition("Queen's Gate 9",-3631.9873046875 ,3256.8044433594 ,-664.01226806641),
NamedPosition("Queen's Gate 10",-684.96215820313 ,-4139.5014648438 ,727.00970458984),
NamedPosition("Queen's Gate 11",3432.5673828125 ,-17690.873046875 ,-156.75831604004),
NamedPosition("Queen's Gate 12",-8738.7158203125 ,-23244.94921875 ,-466.61846923828),
NamedPosition("Queen's Gate 13",-4723.4150390625 ,-15244.786132813 ,-3.1336839199066),
NamedPosition("Queen's Gate 14",-10899.760742188 ,-13725.379882813 ,-232.99530029297),
NamedPosition("Queen's Gate 15",-17185.251953125 ,-16724.1328125 ,-310.3762512207),

}},
{"Ossu-Gol Necropolis (20)",{nil,
NamedPosition("Ossu-Gol Necropolis 1",-74284.734375 ,-22289.798828125 ,-1953.6291503906),
NamedPosition("Ossu-Gol Necropolis 2",-79839.3046875 ,-4590.0126953125 -2705.5627441406),
NamedPosition("Ossu-Gol Necropolis 3",-58359.6953125 ,6030.0678710938 ,635.55126953125),
NamedPosition("Ossu-Gol Necropolis 4",-54681.0859375 ,-3375.8566894531 ,1508.4951171875),
NamedPosition("Ossu-Gol Necropolis 5",-50723.16796875 ,-6553.7724609375 ,2275.0007324219),
NamedPosition("Ossu-Gol Necropolis 6",-49902.8046875 ,3266.1369628906 ,2084.009765625),
NamedPosition("Ossu-Gol Necropolis 7",-41261.98046875 ,-3418.9360351563 ,1826.1501464844),
NamedPosition("Ossu-Gol Necropolis 8",-40418.23828125 ,2681.7272949219 ,2008.1341552734),
NamedPosition("Ossu-Gol Necropolis 9",-42681.3828125 ,17297.525390625 ,2146.1499023438),
NamedPosition("Ossu-Gol Necropolis 10",-36399.53515625 ,-796.47198486328 ,3771.1499023438),
NamedPosition("Ossu-Gol Necropolis 11",-35648.203125 ,-1879.3544921875 ,2408.6755371094),
NamedPosition("Ossu-Gol Necropolis 12",-31713.712890625 ,-7880.3813476563 ,2931.1030273438),
NamedPosition("Ossu-Gol Necropolis 13",-21312.029296875 ,-169.11042785645 ,2983.0144042969),
NamedPosition("Ossu-Gol Necropolis 14",-28110.6875 ,3908.8051757813 ,3007.7131347656),
NamedPosition("Ossu-Gol Necropolis 15",-13856.092773438 ,-5744.3950195313 ,3408.4685058594),
NamedPosition("Ossu-Gol Necropolis 16",-14954.181640625 ,-5154.5766601563 ,1135.0007324219),
NamedPosition("Ossu-Gol Necropolis 17",-19587.8828125 ,-21105.703125 ,237.59857177734),
NamedPosition("Ossu-Gol Necropolis 18",-7837.2993164063 ,-8726.3310546875 ,416.05404663086),
NamedPosition("Ossu-Gol Necropolis 19",-2644.5578613281 ,3648.0595703125 ,4769.208984375),
NamedPosition("Ossu-Gol Necropolis 20",20620.130859375 ,-1131.5184326172 ,5665.4741210938),

}},
{"Wargtooth Shallows (21)",{nil,
NamedPosition("Wargtooth Shallows 1",-18285.751953125 ,-29323.423828125  ,16124.44140625),
NamedPosition("Wargtooth Shallows 2",-16619.08203125 ,-30400.9296875 ,16873.662109375),
NamedPosition("Wargtooth Shallows 3",-17025.01171875 ,-33215.59765625 ,12767.067382813),
NamedPosition("Wargtooth Shallows 4",-3792.4919433594 ,-28829.890625 ,11850.642578125),
NamedPosition("Wargtooth Shallows 5",6948.8818359375 ,-43845.68359375 ,9857.908203125),
NamedPosition("Wargtooth Shallows 6",14649.438476563 ,-35662.578125 ,11582.46484375),
NamedPosition("Wargtooth Shallows 7",-8656.5703125 ,-14702.990234375 ,10775.29296875),
NamedPosition("Wargtooth Shallows 8",-7232.8461914063 ,-15955.043945313 ,9665.224609375),
NamedPosition("Wargtooth Shallows 9",-9898.1103515625 ,-6446.1333007813 ,8090.3115234375),
NamedPosition("Wargtooth Shallows 10",27695.064453125 ,-8849.060546875 ,10428.637695313),
NamedPosition("Wargtooth Shallows 11",17098.931640625 ,-8163.0390625 ,9938.837890625),
NamedPosition("Wargtooth Shallows 12",19791.947265625 ,-2511.6799316406 ,3744.2004394531),
NamedPosition("Wargtooth Shallows 13",15095.900390625 ,1120.9603271484 ,2764.7338867188),
NamedPosition("Wargtooth Shallows 14",21380.677734375 ,12759.141601563 ,2847.7495117188),
NamedPosition("Wargtooth Shallows 15",17474.220703125 ,10140.560546875 ,3441.2470703125),
NamedPosition("Wargtooth Shallows 16",5514.4458007813 ,18168.828125 ,4700.1015625),
NamedPosition("Wargtooth Shallows 17",802.75622558594 ,6817.5927734375 ,9988.2724609375),
NamedPosition("Wargtooth Shallows 18",-2106.4594726563 ,7526.2348632813 ,6375.5341796875),
NamedPosition("Wargtooth Shallows 19",-1537.8916015625 ,3242.826171875 ,5670.9389648438),
NamedPosition("Wargtooth Shallows 20",-22727.83203125 ,-3360.9426269531 ,8454.40234375),
NamedPosition("Wargtooth Shallows 21",-40757.01171875 ,-14921.470703125 ,8819.7421875),

}},
{"WeepWild Dankness (21)",{nil,
NamedPosition("WeepWild Dankness 1",-6376.2197265625 ,-19657.4140625 ,616.20629882813),
NamedPosition("WeepWild Dankness 2",4924.8168945313 ,-18626.658203125 ,2767.2041015625),
NamedPosition("WeepWild Dankness 3",940.95922851563 ,-16349.577148438 ,898.76867675781),
NamedPosition("WeepWild Dankness 4",12334.288085938 ,-18030.353515625 ,1597.1397705078),
NamedPosition("WeepWild Dankness 5",23574.875 ,-26712.84375 ,2879.970703125),
NamedPosition("WeepWild Dankness 6",28988.794921875 ,-20029.970703125 ,4235.77734375),
NamedPosition("WeepWild Dankness 7",27114.1015625 ,-8299.962890625 ,3693.1955566406),
NamedPosition("WeepWild Dankness 8",17708.73046875 ,-7942.1489257813 ,1886.2537841797),
NamedPosition("WeepWild Dankness 9",15177.333007813 ,-14380.475585938 ,3380.1848144531),
NamedPosition("WeepWild Dankness 10",15113.784179688 ,-5017.6606445313 ,2973.6337890625),
NamedPosition("WeepWild Dankness 11",26972.53125 ,8094.599609375 ,3539.4135742188),
NamedPosition("WeepWild Dankness 12",8722.06640625 ,-4271.7412109375 ,404.52169799805),
NamedPosition("WeepWild Dankness 13",7535.787109375 ,-6710.8271484375 ,1549.0397949219),
NamedPosition("WeepWild Dankness 14",-264.28378295898 ,-6560.5688476563 ,2228.4011230469),
NamedPosition("WeepWild Dankness 15",2251.1142578125 ,-4367.4926757813 ,356.21405029297),
NamedPosition("WeepWild Dankness 16",5083.8061523438 ,3487.4252929688 ,2300.189453125),
NamedPosition("WeepWild Dankness 17",1750.4599609375 ,5981.4765625 ,1357.7840576172),
NamedPosition("WeepWild Dankness 18",5101.1796875 ,9706.6953125 ,1806.3310546875),
NamedPosition("WeepWild Dankness 19",10506.583984375 ,11556.890625 ,1523.8693847656),
NamedPosition("WeepWild Dankness 20",19254.376953125 ,9436.2373046875 ,2835.0310058594),
NamedPosition("WeepWild Dankness 21",-13323.78515625 ,-42193.44921875 ,2655.5046386719),

}},
{"Drowned Abyss (20)",{nil,
NamedPosition("Drowned Abyss 1",-13323.78515625 ,-42193.44921875 ,2655.5046386719),
NamedPosition("Drowned Abyss 2",-6339.0102539063 ,-41677.1640625 ,1921.4055175781),
NamedPosition("Drowned Abyss 3",-6340.1982421875 ,-30949.9453125 ,2130.2834472656),
NamedPosition("Drowned Abyss 4",-1996.0733642578 ,-28966.701171875 ,1839.3737792969),
NamedPosition("Drowned Abyss 5",34803.921875 ,-32690.955078125 ,3124.0908203125),
NamedPosition("Drowned Abyss 6",15681.876953125 ,-18872.072265625 ,2420.1540527344),
NamedPosition("Drowned Abyss 7",25370.326171875 ,-8375.49609375 ,1223.1052246094),
NamedPosition("Drowned Abyss 8",15163.655273438 ,4449.96875 ,1357.9378662109),
NamedPosition("Drowned Abyss 9",8485.921875 ,8048.3994140625 ,3439.3833007813),
NamedPosition("Drowned Abyss 10",1952.9620361328 ,1832.6883544922 ,1743.1805419922),
NamedPosition("Drowned Abyss 11",3263.576171875 ,-11690.23046875 ,1202.3623046875),
NamedPosition("Drowned Abyss 12",-3438.2395019531 ,1733.2795410156 ,-40.888534545898),
NamedPosition("Drowned Abyss 13",-840.91448974609 ,10270.196289063 ,-2907.2097167969),
NamedPosition("Drowned Abyss 14",-926.3388671875 ,21545.890625 ,-2803.7915039063),
NamedPosition("Drowned Abyss 15",-10894.764648438 ,-14786.458007813 ,1909.4180908203),
NamedPosition("Drowned Abyss 16",-10200.276367188 ,-11668.69140625 ,2892.9226074219),
NamedPosition("Drowned Abyss 17",-13890.650390625 ,-16860.033203125 ,796.35632324219),
NamedPosition("Drowned Abyss 18",-20129.212890625 ,640.39434814453 ,4007.1499023438),
NamedPosition("Drowned Abyss 19",-21658.595703125 ,-8581.5810546875 ,2897.8244628906),
NamedPosition("Drowned Abyss 20",-35960.08984375 ,-35392.26171875 ,2349.763671875),

}},
{"Mount Craw (19)",{nil,
NamedPosition("Mount Craw 1",-31681.736328125 ,7303.6303710938 ,4119.431640625),
NamedPosition("Mount Craw 2",-21752.041015625 ,-15497.646484375 ,1736.6820068359),
NamedPosition("Mount Craw 3",-15400.118164063 ,-14401.837890625 ,4323.7099609375),
NamedPosition("Mount Craw 4",-17580.662109375 ,-30080.845703125 ,6263.3759765625),
NamedPosition("Mount Craw 5",-7815.0346679688 ,-22734.109375 ,5708.1391601563),
NamedPosition("Mount Craw 6",-3209.3645019531 ,-35519.6796875 ,10389.543945313),
NamedPosition("Mount Craw 7",-1778.0350341797 ,-31147.2890625 ,4754.4970703125),
NamedPosition("Mount Craw 8",14758.232421875 ,-27817.24609375 ,8015.923828125),
NamedPosition("Mount Craw 9",1415.3405761719 ,-18823.169921875 ,7636.6391601563),
NamedPosition("Mount Craw 10",17222.998046875 ,-10197.418945313 ,6572.8305664063),
NamedPosition("Mount Craw 11",26444.474609375 ,-9908.15625 ,8693.3623046875),
NamedPosition("Mount Craw 12",29726.826171875 ,-8611.9931640625 ,6496.7768554688),
NamedPosition("Mount Craw 13",32228.693359375 ,-21533.19921875 ,7716.0458984375),
NamedPosition("Mount Craw 14",-3686.5407714844 ,-10240.877929688 ,5258.9365234375),
NamedPosition("Mount Craw 15",-1892.193359375 ,5572.0756835938 ,5797.744140625),
NamedPosition("Mount Craw 16",-4850.4697265625 ,12495.12890625 ,5765.8852539063),
NamedPosition("Mount Craw 17",3464.9995117188 ,8048.7021484375 ,7699.2055664063),
NamedPosition("Mount Craw 18",10306.90234375 ,10424.046875 ,6296.3413085938),
NamedPosition("Mount Craw 19",13219.747070313 ,-18755.85546875 ,8072.3149414063),

}},
{"Tangle Drift (21)",{nil,
NamedPosition("Tangle Drift 1",29537.189453125 ,43795.26953125 ,14444.134765625),
NamedPosition("Tangle Drift 2",26830.724609375 ,34883.484375 ,11087.3828125),
NamedPosition("Tangle Drift 3",3876.4079589844 ,35957.47265625 ,17332.72265625),
NamedPosition("Tangle Drift 4",-32634.13671875 ,34111.17578125 ,25064.53515625),
NamedPosition("Tangle Drift 5",-45462.8515625 ,3998.8642578125 ,24556.15234375),
NamedPosition("Tangle Drift 6",-30519.17578125 ,5517.4370117188 ,25879.03515625),
NamedPosition("Tangle Drift 7",-23393.451171875, -10253.931640625, 25360.900390625),
NamedPosition("Tangle Drift 8",-21126.53125 ,-11952.984375 ,27065.57421875),
NamedPosition("Tangle Drift 9",-18250.228515625 ,-12709.818359375 ,25860.0078125),
NamedPosition("Tangle Drift 10",-19915.029296875 ,11931.595703125 ,20478.046875),
NamedPosition("Tangle Drift 11",-671.88543701172 ,18533.326171875 ,18244.966796875),
NamedPosition("Tangle Drift 12",10629.665039063 ,-7200.126953125 ,14313.702148438),
NamedPosition("Tangle Drift 13",16721.029296875 ,-9353.9892578125 ,12976.294921875),
NamedPosition("Tangle Drift 14",21114.5546875 ,-1392.5073242188 ,13691.3515625),
NamedPosition("Tangle Drift 15",28232.98046875 ,-862.86602783203 ,13526.806640625),
NamedPosition("Tangle Drift 16",25717.841796875 ,-18118.7734375 ,12908.56640625),
NamedPosition("Tangle Drift 17",-35144.03515625 ,-29061.4140625 ,24734.646484375),
NamedPosition("Tangle Drift 18",-32239.884765625 ,-46777.4140625 ,25110.396484375),
NamedPosition("Tangle Drift 19",-17406.73046875 ,-43780.3515625 ,26860.72265625),
NamedPosition("Tangle Drift 20",-17010.6171875 ,-52387.90234375 ,28231.15234375),
NamedPosition("Tangle Drift 21",-16354.634765625 ,-50398.171875 ,25106.1484375),

}},
})

TeleportTreeAdd("Lost Marbles",{nil,
NamedPosition("Brighthoof Marble 1",          218.974822998 , -503.346771240 , 3511.61938476),
NamedPosition("Brighthoof Marble 2",          2205.86987304 , 220.4304656982 , 5361.57470703),
NamedPosition("Queen's Gate Marble 1",        -3848.3383789 , 8903.231445312 , 205.229614257),
NamedPosition("Queen's Gate Marble 2",        -3364.3498535 , -23670.2421875 , -13.542389869),
NamedPosition("Wargtooth Shallows Marble 1",  -26894.990234 , -11431.8525390 , 6581.14990234),
NamedPosition("Wargtooth Shallows Marble 2",  3274.58886718 , -25585.6582031 , 10311.8544921),
NamedPosition("Drowned Abyss Marble 1",       -2332.1342773 , -13414.8212890 , 1899.58361816),
NamedPosition("Drowned Abyss Marble 2",       20196.7167968 , -37748.3554687 , 5477.42285156),
NamedPosition("Weepwild Dankness Marble 1",   9025.18164062 , -21057.2753906 , 3023.23071289),
NamedPosition("Weepwild Dankness Marble 2",   17620.3261718 , -685.650207519 , 3135.51489257),
NamedPosition("Karnok's Wall Marble 1",       -30310.853515 , 2454.446533203 , 12419.5078125),
NamedPosition("Karnok's Wall Marble 2",       23780.5019531 , 20951.13281250 , 12819.4277343),
NamedPosition("Ossu-Gol Necropolis Marble 1", -41291.136718 , 2667.304687500 , 3167.89868164),
NamedPosition("Ossu-Gol Necropolis Marble 2", -20533.316406 , 3068.390869140 , 51.0841827392),
NamedPosition("Fearamid Marble 1",            4164.60839843 , 26001.20703125 , 37110.9335937),
NamedPosition("Fearamid Marble 2",            17115.1894531 , 9615.404296875 , 39986.1484375),
NamedPosition("Sunfang Oasis Marble 1",       -83423.421875 , -26931.4941406 , -8419.0332031),
NamedPosition("Sunfang Oasis Marble 2",       -114019.80468 , -3768.11352539 , -9273.7246093),
NamedPosition("Crackmast Cove Marble 1",      -10039.055664 , -27149.8417968 , 1912.46057128),
NamedPosition("Crackmast Cove Marble 2",      -24295.076171 , -18897.1210937 , -1779.1180419),
NamedPosition("Tangle Drift Marble 1",        12395.6992187 , 9463.211914062 , 14893.7373046),
NamedPosition("Tangle Drift Marble 2",        8823.12207031 , -7795.57519531 , 15326.0234375),
NamedPosition("Mount Craw Marble 1",          -19518.031250 , -20358.5546875 , 6686.13623046),
NamedPosition("Mount Craw Marble 2",          -3773.0463867 , -2097.62353515 , 5110.66650390),

})


TeleportTreeAdd("Shrines",{

{"Mool Ah",{nil,
NamedPosition("Shrine",2719.7648925781,-9141.4150390625,573.93585205078),
NamedPosition("Mool Ah 1",-4055.2744140625,-5595.3930664063,624.53125),
NamedPosition("Mool Ah 2",1206.7413330078,-12128.256835938,1627.2590332031),
}},

{"Zoomios",{nil,
NamedPosition("Shrine/Zoomios 1",22210.365234375,-10323.342773438,1061.275390625),
NamedPosition("Zoomios 2",6049.71875,-14055.122070313,814.59875488281),
NamedPosition("Zoomios 3",12808.74609375,4324.0346679688,1106.7211914063),
NamedPosition("Zoomios 4",23614.498046875,-1785.4575195313,1125.9689941406),
}},

{"Grindanna",{nil,
NamedPosition("Shrine/Grindanna 1",16604.822265625,-22883.3046875,-1248.7799072266),
NamedPosition("Grindanna 2",21404.1953125,-18633.798828125,-1049.0690917969),
NamedPosition("Grindanna 3",5735.1391601563,-16052.329101563,-552.97375488281),
NamedPosition("Grindanna 4",-2325.4079589844,-16367.296875,1471.1749267578),
}},

{"Throatus Punchus",{nil,
NamedPosition("Throatus Punchus Shrine",9507.693359375,-28816.646484375,-1003.9183959961),
NamedPosition("Throatus Punchus 1",13371.163085938,-32584.255859375,-2492.0017089844),
NamedPosition("Throatus Punchus 2",54.919990539551,-30531.953125,-225.56288146973),
NamedPosition("Throatus Punchus 3",17366.353515625,-40067.140625,-2194.3352050781),
NamedPosition("Throatus Punchus 4",6455.7983398438,-43023.7734375,-1297.1264648438),
}},

{"Aaron G",{nil,
NamedPosition("Shrine/Aaron G 1",8280.216796875,-49365.765625,1649.0628662109),
NamedPosition("Aaron G 2",18032.84375,-48042.765625,1448.3787841797),
NamedPosition("Aaron G 3",2407.2185058594,-63235.7109375,2608.2846679688),
NamedPosition("Aaron G 4",-13461.4765625,-54187.45703125,1194.0554199219),
}},

{"Crazed Earl",{nil,
NamedPosition("Shrine",-5388.6674804688,-60640.62890625,1836.5046386719),
NamedPosition("Crazed Earl 1",-2396.611328125,-59149.55078125,1374.3380126953),
NamedPosition("Crazed Earl 2",-8469.6455078125,-55908.8046875,1304.2238769531),
NamedPosition("Crazed Earl 3",-5898.7109375,-50448.921875,925.04516601563),
NamedPosition("Crazed Earl 4",-3858.6469726563,-50454.68359375,355.65667724609),
}},

});


TeleportTreeAdd("Scrolls",{
{"Brighthoof",{nil,
NamedPosition("Brighthoof 1",9293.345703125,-7034.4663085938,4308.533203125),
NamedPosition("Brighthoof 2",73.070426940918,-3772.3176269531,4717.5048828125),
NamedPosition("Brighthoof 3",5369.5380859375,2441.9450683594,5315.5361328125),

}},
{"CrackMast Cove",{nil,
NamedPosition("Crackmast Cove 1",-29495.310546875,-34142.53515625,-2197.8017578125),
NamedPosition("Crackmast Cove 2",-17560.6171875,-17411.03125,-1476.974609375),
NamedPosition("Crackmast Cove 3",-8369.7578125,-2604.0710449219,-2323.869140625),
NamedPosition("Crackmast Cove 4",9574.2255859375,-20603.126953125,-1413.599609375),
NamedPosition("Crackmast Cove 5",297.72567749023,-25614.037109375,921.32250976563),
NamedPosition("Crackmast Cove 6 (Unsure atm)",38451.9609375,10.056752204895,-1987.5999755859),

}},
{"Drowned Abyss",{nil,
NamedPosition("Drowned Abyss 1",-7566.2153320313,-43232.828125,1779.3665771484),
NamedPosition("Drowned Abyss 2",-679.23181152344,-33299.84765625,1839.3734130859),
NamedPosition("Drowned Abyss 3",-17501.271484375,-27568.44140625,2089.7446289063),

}},
{"Fearamid",{nil,
NamedPosition("Fearamid 1",6798.279296875,11731.209960938,35916.19921875),
NamedPosition("Fearamid 2",1954.5190429688,-6260.0375976563,37027.90234375),
NamedPosition("Fearamid 3",4508.3354492188,24149.306640625,36904.0703125),

}},
{"Karnok's Wall",{nil,
NamedPosition("Karnok's Wall 1",5132.9560546875,14436.719726563,9746.6875),
NamedPosition("Karnok's Wall 2",29085.154296875,13974.157226563,13423.095703125),
NamedPosition("Karnok's Wall 3",-2803.8979492188,30855.79296875,21932.4140625),
NamedPosition("Karnok's Wall 4",-25384.32421875,5903.904296875,12330.463867188),

}},
{"Mount Craw",{nil,
NamedPosition("Mount Craw 1",-32580.94921875,-16042.485351563,7.3114681243896),
NamedPosition("Mount Craw 2",-14912.951171875,-12572.889648438,5029.5502929688),
NamedPosition("Mount Craw 3",-11180.974609375,-19970.84765625,5548.3862304688),
NamedPosition("Mount Craw 4",18900.01953125,-22981.080078125,8309.22265625),
NamedPosition("Mount Craw 5",3514.7075195313,-36739.21484375,10266.845703125),

}},
{"Overworld",{nil,
NamedPosition("Overworld 1",1361.0368652344,-13938.72265625,971.59252929688),
NamedPosition("Overworld 2",17238.46875,-8744.537109375,1416.9968261719),
NamedPosition("Overworld 3",-281.93887329102,-39229.27734375,335.81271362305),
NamedPosition("Overworld 4",15101.818359375,-45075.6640625,1497.8590087891),
NamedPosition("Overworld 5",2270.5009765625,-62901.30859375,2608.2846679688),
NamedPosition("Overworld 6",-10122.962890625,-45101.015625,1200.3582763672),

}},
{"Oss-Gol Necropolis",{nil,
NamedPosition("Oss-Gol Necropolis 1",-30428.328125,-2835.3115234375,3006.1501464844),
NamedPosition("Oss-Gol Necropolis 2",-4530.2514648438,-14409.40234375,466.44427490234),
NamedPosition("Oss-Gol Necropolis 3",-49434.875,-10446.184570313,1510.8131103516),

}},
{"Queen's Gate",{nil,
NamedPosition("Queens Gate 1",-15332.275390625,-5702.05859375,-395.46994018555),
NamedPosition("Queens Gate 2",-12575.219726563,6232.126953125,-551.26776123047),
NamedPosition("Queens Gate 3",-4430.1499023438,-22482.65234375,332.03216552734),

}},
{"Sunfang Oasis",{nil,
NamedPosition("Sunfang Oasis 1",-67011.34375,-2705.6779785156,-3188.96875),
NamedPosition("Sunfang Oasis 2",-85285.3203125,21827.78125,-8288.849609375),
NamedPosition("Sunfang Oasis 3",-78638.015625,21263.001953125,-9002.7451171875),
NamedPosition("Sunfang Oasis 4",-77309.9921875,21985.2734375,-9003.046875),
NamedPosition("Sunfang Oasis 5",-76463.8828125,20212.439453125,-9002.9130859375),
NamedPosition("Sunfang Oasis 6",-77803.4921875,19606.373046875,-9002.751953125),
NamedPosition("Sunfang Oasis 7",-38135.5625,532.62921142578,-13733.849609375),
NamedPosition("Sunfang Oasis 8",-87152.7421875,-25385.7421875,-8429.427734375),
}},
{"Snoring Valley",{nil,
NamedPosition("Snoring Valley 1",2639.8676757813,-8954.4677734375,603.23400878906),
NamedPosition("Snoring Valley 2",-17444.142578125,15880.916015625,-1114.3463134766),

}},
{"Tangle Drift",{nil,
NamedPosition("Tangledrift 1",37921.91796875,12452.522460938,16424.98046875),
NamedPosition("Tangledrift 2",-14632.146484375,12079.702148438,20624.5625),
NamedPosition("Tangledrift 3",-21501.849609375,-4113.7124023438,25312.595703125),
NamedPosition("Tangledrift 4",-20621.912109375,-48951.78515625,27435.673828125),
NamedPosition("Tangledrift 5",27574.66796875,-18249.171875,12914.245117188),

}},
{"Wargtooth Shallows",{nil,
NamedPosition("Wargtooth Shallows 1",14277.611328125,-31888.990234375,11282.890625),
NamedPosition("Wargtooth Shallows 2",-7974.484375,-28268.62890625,11515.08203125),
NamedPosition("Wargtooth Shallows 3",-7063.8627929688,-2756.4802246094,7597.6591796875),
NamedPosition("Wargtooth Shallows 4",5920.90625,6256.7685546875,7305.8911132813),

}},
{"WeepWild Dankness",{nil,
NamedPosition("WeepWild Dankness 1",-8883.287109375,-2349.1843261719,-228.02810668945),
NamedPosition("WeepWild Dankness 2",5500.2705078125,9954.17578125,1806.3310546875),
NamedPosition("WeepWild Dankness 3",17595.18359375,-980.50592041016,3125.1286621094),

}},
});



TeleportTreeAdd("Rune Switches",{nil,--Mas
NamedPosition("Brighthoof",         6030.6635742 , 4095.29711 , 6924.999511),
NamedPosition("Crackmast Cove",     9121.9775390 , -16723.802 , 374.9964599),
NamedPosition("Drowned Abyss",      -10016.77441 , -5792.2348 , 958.8265991),
NamedPosition("Fearamid",           7460.0507812 , -1979.3089 , 37232.88281),
NamedPosition("Karnok's Wall",      20274.722656 , 9399.26953 , 4581.235351),
NamedPosition("Mount Craw",         29385.384765 , -17653.406 , 8050.600585),
NamedPosition("Oss-Gol Necropolis", -33651.96875 , 5865.05078 , 3433.838378),
NamedPosition("Queens Gate",        -29737.03906 , -7316.0214 , 728.7711181),
NamedPosition("Sunfang Oasis",      -96067.83593 , 1022.96356 , -7917.12304),
NamedPosition("Tangledrift",        24991.671875 , -1639.7211 , 13303.25683),
NamedPosition("Wargtooth Shallows", -8529.491210 , -31430.421 , 11521.39746),
NamedPosition("WeepWild Dankness",  29525.386718 , 3284.81567 , 4537.220703),
});



TeleportTreeAdd("Ancient Oblisk",{nil,--Mas
NamedPosition("Crackmast Cove",     -6813.254882 , -20162.5917968 , -1713.28540039),
NamedPosition("Drowned Abyss",      26094.667968 , -28797.0976562 , 3121.513183593),
NamedPosition("Fearamid",           7032.4296875 , 12135.67285156 , 34074.40234375),
NamedPosition("Karnok's Wall",      -17008.50195 , 2238.512207031 , 5062.755371093),
NamedPosition("Mount Craw",         -8653.260742 , -36158.7812500 , 5019.543457031),
NamedPosition("Queens Gate",        -31991.02734 , -32631.6953125 , -2499.05224609),
NamedPosition("Oss-Gol Necropolis", 3803.1694335 , -7627.17626953 , -422.432006835),
NamedPosition("Sunfang Oasis",      -99519.17968 , -31321.5175781 , -10419.4414062),
NamedPosition("Tangledrift",        31009.265625 , -9672.86035156 , 12122.98828125),
NamedPosition("Wargtooth Shallows", 17915.474609 , -42809.1718750 , 10719.06347656),
NamedPosition("WeepWild Dankness",  24632.960937 , -24321.6171875 , 2724.410156250),
});



TeleportTreeAdd("Repeatable Missions",{nil,
NamedPosition("Karnok's Wall",28682.962890625 , 52703.40625, 13459.396484375),

});


TeleportTreeAdd("Extra Locations",{
{"Chaos Chamber",{nil,
NamedPosition("Ontop Of Chaos Chamber Die/Dice", 15.2665 , 7.68509 , -6844.0092 ),
NamedPosition("Spawn", -8.662079811 , 4839.764648 ,-10797.8457 ),
NamedPosition("Enchantment Re-Roller", -815.7484741 , 2537.20752 ,-11138.72461 ),
NamedPosition("Bank", 796.194458 , 2608.805908 ,-11138.72461 ),
NamedPosition("Quick Change", 1576.352539 , 2398.161377 ,-11138.72461 ),
NamedPosition("Dragonlord (Friendly) Spawn", 153.4382019 , 2294.35083 ,-11138.72461 ),
NamedPosition("Challenge Start Portal", 1.319947124 , 26.73083687 ,-10958.86523 ),
NamedPosition("Brighthoof Fast Travel", -17.45985794 , 6359.778809 ,-10844.32812 ),

}},
});