//================================================================================
// DamType_ShockCombo.
//================================================================================

class DamType_ShockCombo extends DamTypeShockCombo;

var int AwardLevel;

static function IncrementKills (Controller Killer)
{
  local Misc_PRI xPRI;

  xPRI = Misc_PRI(Killer.PlayerReplicationInfo);
  if ( xPRI != None )
  {
    xPRI.combocount++;
    if ( (xPRI.combocount == Default.AwardLevel) && (Misc_Player(Killer) != None) )
    {
      Misc_Player(Killer).BroadcastAnnouncement(Class'Message_Combowhore');
    }
  }
}

defaultproperties
{
     AwardLevel=8
}
