/*******************************************************************************
 * DamType_LinkShaft generated by Eliot.UELib using UE Explorer.
 * Eliot.UELib � 2009-2015 Eliot van Uytfanghe. All rights reserved.
 * http://eliotvu.com
 *
 * All rights belong to their respective owners.
 *******************************************************************************/
class DamType_LinkShaft extends DamTypeLinkShaft;

var int AwardLevel;

static function IncrementKills(Controller Killer)
{
    local Misc_PRI xPRI;

    xPRI = Misc_PRI(Killer.PlayerReplicationInfo);
    
    if(xPRI != none)
    {
        ++ xPRI.LinkCount;
        
        if((xPRI.LinkCount == default.AwardLevel) && Misc_Player(Killer) != none)
        {
            Misc_Player(Killer).BroadcastAnnouncement(class'Message_LinkShafter');
        }
    }
   
}

defaultproperties
{
     AwardLevel=5
     WeaponClass=Class'3SPNvSoL.NewNet_LinkGun'
     bSkeletize=False
     bCauseConvulsions=True
     bCausesBlood=True
     bLeaveBodyEffect=False
}
