class TeamColorRocketTrail extends Emitter
	notplaceable;

#exec OBJ LOAD FILE=AS_FX_TX.utx

var int TeamNum;
var bool bColorSet;

simulated function PreBeginPlay()
{
	if ( Level.DetailMode == DM_Low )
	{
		TrailEmitter(Emitters[0]).MaxPointsPerTrail = 100;
	}

	super.PreBeginPlay();
}


// get replicated team number from owner projectile and set texture
function SetColors()
{
    local Color color;
    if(class'Misc_Player'.default.bTeamColorRockets && !bColorSet)
    {
        if(TeamColorRocketProj(Owner) != None)
            TeamNum = TeamColorRocketProj(Owner).TeamNum;
        else if(TeamColorSeekingRocketProj(Owner) != None)
            TeamNum = TeamColorSeekingRocketProj(Owner).TeamNum;

        color = class'TeamColorManager'.static.GetColor(TeamNum, Level.GetLocalPlayerController());
        if(TeamNum == 0)
        {
            bHidden=false;
            Emitters[0].Texture=Texture'AS_FX_TX.Trails.Trail_Red';
            Emitters[1].ColorScale[0].Color=color;
            Emitters[1].ColorScale[1].Color=color;
            Emitters[1].ColorScale[2].Color=color;
            Emitters[0].Reset();
            Emitters[1].Reset();
            bColorSet=true;
        }
        else if(TeamNum == 1)
        {
            bHidden=false;
            Emitters[0].Texture=Texture'AS_FX_TX.Trails.Trail_Blue';
            Emitters[1].ColorScale[0].Color=color;
            Emitters[1].ColorScale[1].Color=color;
            Emitters[1].ColorScale[2].Color=color;
            Emitters[0].Reset();
            Emitters[1].Reset();
            bColorSet=true;
        }
    }
}

simulated function PostNetBeginPlay()
{
    super.PostNetBeginPlay();

    if(Level.NetMode == NM_DedicatedServer)
        return;
        
    SetColors();
}

simulated function Tick(float DT)
{
    super.Tick(DT);
    SetColors();
}

defaultproperties
{


    Begin Object Class=TrailEmitter Name=TrailEmitter0
		Opacity=0.67
        TrailLocation=PTTL_FollowEmitter
        MaxPointsPerTrail=200
        DistanceThreshold=50.0
        UseCrossedSheets=true
        PointLifeTime=1
        MaxParticles=1
        //StartSizeRange=(X=(Min=10.0,Max=10.0))
        StartSizeRange=(X=(Min=2.5,Max=2.5))
        InitialParticlesPerSecond=2000.000000
        AutomaticInitialSpawning=false
		SecondsBeforeInactive=0.0
        Texture=Texture'AS_FX_TX.Trails.Trail_Blue'
        LifetimeRange=(Min=999999,Max=999999)
		TrailShadeType=PTTST_Linear
        Name="TrailEmitter0"
    End Object
    Emitters(0)=TrailEmitter'TrailEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter22
        ProjectionNormal=(X=1.000000,Z=0.000000)
        UseColorScale=True
        ColorScale(0)=(Color=(B=255,G=128,R=64))
        ColorScale(1)=(RelativeTime=0.750000,Color=(B=255,G=128,R=64))
        ColorScale(2)=(RelativeTime=1.000000)
		Opacity=0.67
		CoordinateSystem=PTCS_Relative
		RespawnDeadParticles=false
        MaxParticles=5
        StartLocationOffset=(X=-10.000000)
        SpinParticles=True
        SpinCCWorCW=(X=0.000000,Y=0.000000,Z=0.000000)
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.200000))
        StartSpinRange=(X=(Max=1.000000))
        UseSizeScale=True
        UseRegularSizeScale=False
        SizeScale(0)=(RelativeSize=0.100000)
        SizeScale(1)=(RelativeTime=0.100000,RelativeSize=1.500000)
        SizeScale(2)=(RelativeTime=0.150000,RelativeSize=1.000000)
        SizeScale(3)=(RelativeTime=1.000000,RelativeSize=0.750000)
        //StartSizeRange=(X=(Min=100.000000,Max=500.000000))
        StartSizeRange=(X=(Min=25.000000,Max=125.000000))
        UniformSize=True
        InitialParticlesPerSecond=50.000000
        AutomaticInitialSpawning=False
        Texture=Texture'EpicParticles.Flares.FlickerFlare'
		SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=2.000000,Max=10.000000)
        InitialDelayRange=(Min=0.050000,Max=0.050000)
        Name="SpriteEmitter22"
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter22'

	bStasis=false
	bDirectional=true
	bHardAttach=true
    bNoDelete=false
	RemoteRole=ROLE_None
    TeamNum=255
    bHidden=true
}