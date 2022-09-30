 $diskpart = "sel disk 0";
  $diskpart += "`r`n";
  $diskpart += "sel partition 1";
  $diskpart += "`r`n";
  $diskpart +="inactive";
  $diskpart += "`r`n";
  $diskpart += "exit";
  $diskpart | diskpart;
  Restart-Computer -Force
