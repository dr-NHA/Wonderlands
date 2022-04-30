


Wonderlands._T={};
Wonderlands._T.F="*:Please Follow The Above Instructions!";
Wonderlands._T.A="*:Must Run UE4 Dumper";
Wonderlands._T.B="Kraqur";
Wonderlands._T.C="dr-NHA";
Wonderlands.OtherItemPoolMemoryRecords={
'Item Pool Changer Vending Maching',
}

Wonderlands.TargetItemPoolMemoryRecords={
'Target Health Item Pool',
'Target Ammo Item Pool',
'Target Ammo 2 Item Pool',
'Target Money Item Pool',
'Target Weapons Item Pool',
'Target Moon Orbs Item Pool',
'Target Shields Item Pool',
'Target Spells Item Pool',
'Target Melee Item Pool',
'Target Rings Item Pool',
'Target Amulets Item Pool',
'Target Pauldron Item Pool',
};

function Wonderlands.SetItemPoolMemoryRecords(val)
Wonderlands.FixMemoryRecords(Wonderlands.OtherItemPoolMemoryRecords,val);
Wonderlands.FixMemoryRecords(Wonderlands.TargetItemPoolMemoryRecords,val);
end

function Wonderlands.ResetItemPoolMemoryRecords()
Wonderlands.SetItemPoolMemoryRecords(nil);
end
Wonderlands.ResetItemPoolMemoryRecords();
