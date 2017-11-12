unit GameControl;

interface

uses
  Math, TypeControl;

type
  TGame = class
  private
    FRandomSeed: Int64;
    FTickCount: LongInt;
    FWorldWidth: Double;
    FWorldHeight: Double;
    FFogOfWarEnabled: Boolean;
    FVictoryScore: LongInt;
    FFacilityCaptureScore: LongInt;
    FVehicleEliminationScore: LongInt;
    FActionDetectionInterval: LongInt;
    FBaseActionCount: LongInt;
    FAdditionalActionCountPerControlCenter: LongInt;
    FMaxUnitGroup: LongInt;
    FTerrainWeatherMapColumnCount: LongInt;
    FTerrainWeatherMapRowCount: LongInt;
    FPlainTerrainVisionFactor: Double;
    FPlainTerrainStealthFactor: Double;
    FPlainTerrainSpeedFactor: Double;
    FSwampTerrainVisionFactor: Double;
    FSwampTerrainStealthFactor: Double;
    FSwampTerrainSpeedFactor: Double;
    FForestTerrainVisionFactor: Double;
    FForestTerrainStealthFactor: Double;
    FForestTerrainSpeedFactor: Double;
    FClearWeatherVisionFactor: Double;
    FClearWeatherStealthFactor: Double;
    FClearWeatherSpeedFactor: Double;
    FCloudWeatherVisionFactor: Double;
    FCloudWeatherStealthFactor: Double;
    FCloudWeatherSpeedFactor: Double;
    FRainWeatherVisionFactor: Double;
    FRainWeatherStealthFactor: Double;
    FRainWeatherSpeedFactor: Double;
    FVehicleRadius: Double;
    FTankDurability: LongInt;
    FTankSpeed: Double;
    FTankVisionRange: Double;
    FTankGroundAttackRange: Double;
    FTankAerialAttackRange: Double;
    FTankGroundDamage: LongInt;
    FTankAerialDamage: LongInt;
    FTankGroundDefence: LongInt;
    FTankAerialDefence: LongInt;
    FTankAttackCooldownTicks: LongInt;
    FTankProductionCost: LongInt;
    FIfvDurability: LongInt;
    FIfvSpeed: Double;
    FIfvVisionRange: Double;
    FIfvGroundAttackRange: Double;
    FIfvAerialAttackRange: Double;
    FIfvGroundDamage: LongInt;
    FIfvAerialDamage: LongInt;
    FIfvGroundDefence: LongInt;
    FIfvAerialDefence: LongInt;
    FIfvAttackCooldownTicks: LongInt;
    FIfvProductionCost: LongInt;
    FArrvDurability: LongInt;
    FArrvSpeed: Double;
    FArrvVisionRange: Double;
    FArrvGroundDefence: LongInt;
    FArrvAerialDefence: LongInt;
    FArrvProductionCost: LongInt;
    FArrvRepairRange: Double;
    FArrvRepairSpeed: Double;
    FHelicopterDurability: LongInt;
    FHelicopterSpeed: Double;
    FHelicopterVisionRange: Double;
    FHelicopterGroundAttackRange: Double;
    FHelicopterAerialAttackRange: Double;
    FHelicopterGroundDamage: LongInt;
    FHelicopterAerialDamage: LongInt;
    FHelicopterGroundDefence: LongInt;
    FHelicopterAerialDefence: LongInt;
    FHelicopterAttackCooldownTicks: LongInt;
    FHelicopterProductionCost: LongInt;
    FFighterDurability: LongInt;
    FFighterSpeed: Double;
    FFighterVisionRange: Double;
    FFighterGroundAttackRange: Double;
    FFighterAerialAttackRange: Double;
    FFighterGroundDamage: LongInt;
    FFighterAerialDamage: LongInt;
    FFighterGroundDefence: LongInt;
    FFighterAerialDefence: LongInt;
    FFighterAttackCooldownTicks: LongInt;
    FFighterProductionCost: LongInt;
    FMaxFacilityCapturePoints: Double;
    FFacilityCapturePointsPerVehiclePerTick: Double;
    FFacilityWidth: Double;
    FFacilityHeight: Double;
    FBaseTacticalNuclearStrikeCooldown: LongInt;
    FTacticalNuclearStrikeCooldownDecreasePerControlCenter: LongInt;
    FMaxTacticalNuclearStrikeDamage: Double;
    FTacticalNuclearStrikeRadius: Double;
    FTacticalNuclearStrikeDelay: LongInt;

  public
    constructor Create(const randomSeed: Int64; const tickCount: LongInt; const worldWidth: Double;
      const worldHeight: Double; const fogOfWarEnabled: Boolean; const victoryScore: LongInt;
      const facilityCaptureScore: LongInt; const vehicleEliminationScore: LongInt;
      const actionDetectionInterval: LongInt; const baseActionCount: LongInt;
      const additionalActionCountPerControlCenter: LongInt; const maxUnitGroup: LongInt;
      const terrainWeatherMapColumnCount: LongInt; const terrainWeatherMapRowCount: LongInt;
      const plainTerrainVisionFactor: Double; const plainTerrainStealthFactor: Double;
      const plainTerrainSpeedFactor: Double; const swampTerrainVisionFactor: Double;
      const swampTerrainStealthFactor: Double; const swampTerrainSpeedFactor: Double;
      const forestTerrainVisionFactor: Double; const forestTerrainStealthFactor: Double;
      const forestTerrainSpeedFactor: Double; const clearWeatherVisionFactor: Double;
      const clearWeatherStealthFactor: Double; const clearWeatherSpeedFactor: Double;
      const cloudWeatherVisionFactor: Double; const cloudWeatherStealthFactor: Double;
      const cloudWeatherSpeedFactor: Double; const rainWeatherVisionFactor: Double;
      const rainWeatherStealthFactor: Double; const rainWeatherSpeedFactor: Double; const vehicleRadius: Double;
      const tankDurability: LongInt; const tankSpeed: Double; const tankVisionRange: Double;
      const tankGroundAttackRange: Double; const tankAerialAttackRange: Double; const tankGroundDamage: LongInt;
      const tankAerialDamage: LongInt; const tankGroundDefence: LongInt; const tankAerialDefence: LongInt;
      const tankAttackCooldownTicks: LongInt; const tankProductionCost: LongInt; const ifvDurability: LongInt;
      const ifvSpeed: Double; const ifvVisionRange: Double; const ifvGroundAttackRange: Double;
      const ifvAerialAttackRange: Double; const ifvGroundDamage: LongInt; const ifvAerialDamage: LongInt;
      const ifvGroundDefence: LongInt; const ifvAerialDefence: LongInt; const ifvAttackCooldownTicks: LongInt;
      const ifvProductionCost: LongInt; const arrvDurability: LongInt; const arrvSpeed: Double;
      const arrvVisionRange: Double; const arrvGroundDefence: LongInt; const arrvAerialDefence: LongInt;
      const arrvProductionCost: LongInt; const arrvRepairRange: Double; const arrvRepairSpeed: Double;
      const helicopterDurability: LongInt; const helicopterSpeed: Double; const helicopterVisionRange: Double;
      const helicopterGroundAttackRange: Double; const helicopterAerialAttackRange: Double;
      const helicopterGroundDamage: LongInt; const helicopterAerialDamage: LongInt;
      const helicopterGroundDefence: LongInt; const helicopterAerialDefence: LongInt;
      const helicopterAttackCooldownTicks: LongInt; const helicopterProductionCost: LongInt;
      const fighterDurability: LongInt; const fighterSpeed: Double; const fighterVisionRange: Double;
      const fighterGroundAttackRange: Double; const fighterAerialAttackRange: Double;
      const fighterGroundDamage: LongInt; const fighterAerialDamage: LongInt; const fighterGroundDefence: LongInt;
      const fighterAerialDefence: LongInt; const fighterAttackCooldownTicks: LongInt;
      const fighterProductionCost: LongInt; const maxFacilityCapturePoints: Double;
      const facilityCapturePointsPerVehiclePerTick: Double; const facilityWidth: Double; const facilityHeight: Double;
      const baseTacticalNuclearStrikeCooldown: LongInt;
      const tacticalNuclearStrikeCooldownDecreasePerControlCenter: LongInt;
      const maxTacticalNuclearStrikeDamage: Double; const tacticalNuclearStrikeRadius: Double;
      const tacticalNuclearStrikeDelay: LongInt);

    function GetRandomSeed: Int64;
    property RandomSeed: Int64 read GetRandomSeed;
    function GetTickCount: LongInt;
    property TickCount: LongInt read GetTickCount;
    function GetWorldWidth: Double;
    property WorldWidth: Double read GetWorldWidth;
    function GetWorldHeight: Double;
    property WorldHeight: Double read GetWorldHeight;
    function GetFogOfWarEnabled: Boolean;
    property IsFogOfWarEnabled: Boolean read GetFogOfWarEnabled;
    function GetVictoryScore: LongInt;
    property VictoryScore: LongInt read GetVictoryScore;
    function GetFacilityCaptureScore: LongInt;
    property FacilityCaptureScore: LongInt read GetFacilityCaptureScore;
    function GetVehicleEliminationScore: LongInt;
    property VehicleEliminationScore: LongInt read GetVehicleEliminationScore;
    function GetActionDetectionInterval: LongInt;
    property ActionDetectionInterval: LongInt read GetActionDetectionInterval;
    function GetBaseActionCount: LongInt;
    property BaseActionCount: LongInt read GetBaseActionCount;
    function GetAdditionalActionCountPerControlCenter: LongInt;
    property AdditionalActionCountPerControlCenter: LongInt read GetAdditionalActionCountPerControlCenter;
    function GetMaxUnitGroup: LongInt;
    property MaxUnitGroup: LongInt read GetMaxUnitGroup;
    function GetTerrainWeatherMapColumnCount: LongInt;
    property TerrainWeatherMapColumnCount: LongInt read GetTerrainWeatherMapColumnCount;
    function GetTerrainWeatherMapRowCount: LongInt;
    property TerrainWeatherMapRowCount: LongInt read GetTerrainWeatherMapRowCount;
    function GetPlainTerrainVisionFactor: Double;
    property PlainTerrainVisionFactor: Double read GetPlainTerrainVisionFactor;
    function GetPlainTerrainStealthFactor: Double;
    property PlainTerrainStealthFactor: Double read GetPlainTerrainStealthFactor;
    function GetPlainTerrainSpeedFactor: Double;
    property PlainTerrainSpeedFactor: Double read GetPlainTerrainSpeedFactor;
    function GetSwampTerrainVisionFactor: Double;
    property SwampTerrainVisionFactor: Double read GetSwampTerrainVisionFactor;
    function GetSwampTerrainStealthFactor: Double;
    property SwampTerrainStealthFactor: Double read GetSwampTerrainStealthFactor;
    function GetSwampTerrainSpeedFactor: Double;
    property SwampTerrainSpeedFactor: Double read GetSwampTerrainSpeedFactor;
    function GetForestTerrainVisionFactor: Double;
    property ForestTerrainVisionFactor: Double read GetForestTerrainVisionFactor;
    function GetForestTerrainStealthFactor: Double;
    property ForestTerrainStealthFactor: Double read GetForestTerrainStealthFactor;
    function GetForestTerrainSpeedFactor: Double;
    property ForestTerrainSpeedFactor: Double read GetForestTerrainSpeedFactor;
    function GetClearWeatherVisionFactor: Double;
    property ClearWeatherVisionFactor: Double read GetClearWeatherVisionFactor;
    function GetClearWeatherStealthFactor: Double;
    property ClearWeatherStealthFactor: Double read GetClearWeatherStealthFactor;
    function GetClearWeatherSpeedFactor: Double;
    property ClearWeatherSpeedFactor: Double read GetClearWeatherSpeedFactor;
    function GetCloudWeatherVisionFactor: Double;
    property CloudWeatherVisionFactor: Double read GetCloudWeatherVisionFactor;
    function GetCloudWeatherStealthFactor: Double;
    property CloudWeatherStealthFactor: Double read GetCloudWeatherStealthFactor;
    function GetCloudWeatherSpeedFactor: Double;
    property CloudWeatherSpeedFactor: Double read GetCloudWeatherSpeedFactor;
    function GetRainWeatherVisionFactor: Double;
    property RainWeatherVisionFactor: Double read GetRainWeatherVisionFactor;
    function GetRainWeatherStealthFactor: Double;
    property RainWeatherStealthFactor: Double read GetRainWeatherStealthFactor;
    function GetRainWeatherSpeedFactor: Double;
    property RainWeatherSpeedFactor: Double read GetRainWeatherSpeedFactor;
    function GetVehicleRadius: Double;
    property VehicleRadius: Double read GetVehicleRadius;
    function GetTankDurability: LongInt;
    property TankDurability: LongInt read GetTankDurability;
    function GetTankSpeed: Double;
    property TankSpeed: Double read GetTankSpeed;
    function GetTankVisionRange: Double;
    property TankVisionRange: Double read GetTankVisionRange;
    function GetTankGroundAttackRange: Double;
    property TankGroundAttackRange: Double read GetTankGroundAttackRange;
    function GetTankAerialAttackRange: Double;
    property TankAerialAttackRange: Double read GetTankAerialAttackRange;
    function GetTankGroundDamage: LongInt;
    property TankGroundDamage: LongInt read GetTankGroundDamage;
    function GetTankAerialDamage: LongInt;
    property TankAerialDamage: LongInt read GetTankAerialDamage;
    function GetTankGroundDefence: LongInt;
    property TankGroundDefence: LongInt read GetTankGroundDefence;
    function GetTankAerialDefence: LongInt;
    property TankAerialDefence: LongInt read GetTankAerialDefence;
    function GetTankAttackCooldownTicks: LongInt;
    property TankAttackCooldownTicks: LongInt read GetTankAttackCooldownTicks;
    function GetTankProductionCost: LongInt;
    property TankProductionCost: LongInt read GetTankProductionCost;
    function GetIfvDurability: LongInt;
    property IfvDurability: LongInt read GetIfvDurability;
    function GetIfvSpeed: Double;
    property IfvSpeed: Double read GetIfvSpeed;
    function GetIfvVisionRange: Double;
    property IfvVisionRange: Double read GetIfvVisionRange;
    function GetIfvGroundAttackRange: Double;
    property IfvGroundAttackRange: Double read GetIfvGroundAttackRange;
    function GetIfvAerialAttackRange: Double;
    property IfvAerialAttackRange: Double read GetIfvAerialAttackRange;
    function GetIfvGroundDamage: LongInt;
    property IfvGroundDamage: LongInt read GetIfvGroundDamage;
    function GetIfvAerialDamage: LongInt;
    property IfvAerialDamage: LongInt read GetIfvAerialDamage;
    function GetIfvGroundDefence: LongInt;
    property IfvGroundDefence: LongInt read GetIfvGroundDefence;
    function GetIfvAerialDefence: LongInt;
    property IfvAerialDefence: LongInt read GetIfvAerialDefence;
    function GetIfvAttackCooldownTicks: LongInt;
    property IfvAttackCooldownTicks: LongInt read GetIfvAttackCooldownTicks;
    function GetIfvProductionCost: LongInt;
    property IfvProductionCost: LongInt read GetIfvProductionCost;
    function GetArrvDurability: LongInt;
    property ArrvDurability: LongInt read GetArrvDurability;
    function GetArrvSpeed: Double;
    property ArrvSpeed: Double read GetArrvSpeed;
    function GetArrvVisionRange: Double;
    property ArrvVisionRange: Double read GetArrvVisionRange;
    function GetArrvGroundDefence: LongInt;
    property ArrvGroundDefence: LongInt read GetArrvGroundDefence;
    function GetArrvAerialDefence: LongInt;
    property ArrvAerialDefence: LongInt read GetArrvAerialDefence;
    function GetArrvProductionCost: LongInt;
    property ArrvProductionCost: LongInt read GetArrvProductionCost;
    function GetArrvRepairRange: Double;
    property ArrvRepairRange: Double read GetArrvRepairRange;
    function GetArrvRepairSpeed: Double;
    property ArrvRepairSpeed: Double read GetArrvRepairSpeed;
    function GetHelicopterDurability: LongInt;
    property HelicopterDurability: LongInt read GetHelicopterDurability;
    function GetHelicopterSpeed: Double;
    property HelicopterSpeed: Double read GetHelicopterSpeed;
    function GetHelicopterVisionRange: Double;
    property HelicopterVisionRange: Double read GetHelicopterVisionRange;
    function GetHelicopterGroundAttackRange: Double;
    property HelicopterGroundAttackRange: Double read GetHelicopterGroundAttackRange;
    function GetHelicopterAerialAttackRange: Double;
    property HelicopterAerialAttackRange: Double read GetHelicopterAerialAttackRange;
    function GetHelicopterGroundDamage: LongInt;
    property HelicopterGroundDamage: LongInt read GetHelicopterGroundDamage;
    function GetHelicopterAerialDamage: LongInt;
    property HelicopterAerialDamage: LongInt read GetHelicopterAerialDamage;
    function GetHelicopterGroundDefence: LongInt;
    property HelicopterGroundDefence: LongInt read GetHelicopterGroundDefence;
    function GetHelicopterAerialDefence: LongInt;
    property HelicopterAerialDefence: LongInt read GetHelicopterAerialDefence;
    function GetHelicopterAttackCooldownTicks: LongInt;
    property HelicopterAttackCooldownTicks: LongInt read GetHelicopterAttackCooldownTicks;
    function GetHelicopterProductionCost: LongInt;
    property HelicopterProductionCost: LongInt read GetHelicopterProductionCost;
    function GetFighterDurability: LongInt;
    property FighterDurability: LongInt read GetFighterDurability;
    function GetFighterSpeed: Double;
    property FighterSpeed: Double read GetFighterSpeed;
    function GetFighterVisionRange: Double;
    property FighterVisionRange: Double read GetFighterVisionRange;
    function GetFighterGroundAttackRange: Double;
    property FighterGroundAttackRange: Double read GetFighterGroundAttackRange;
    function GetFighterAerialAttackRange: Double;
    property FighterAerialAttackRange: Double read GetFighterAerialAttackRange;
    function GetFighterGroundDamage: LongInt;
    property FighterGroundDamage: LongInt read GetFighterGroundDamage;
    function GetFighterAerialDamage: LongInt;
    property FighterAerialDamage: LongInt read GetFighterAerialDamage;
    function GetFighterGroundDefence: LongInt;
    property FighterGroundDefence: LongInt read GetFighterGroundDefence;
    function GetFighterAerialDefence: LongInt;
    property FighterAerialDefence: LongInt read GetFighterAerialDefence;
    function GetFighterAttackCooldownTicks: LongInt;
    property FighterAttackCooldownTicks: LongInt read GetFighterAttackCooldownTicks;
    function GetFighterProductionCost: LongInt;
    property FighterProductionCost: LongInt read GetFighterProductionCost;
    function GetMaxFacilityCapturePoints: Double;
    property MaxFacilityCapturePoints: Double read GetMaxFacilityCapturePoints;
    function GetFacilityCapturePointsPerVehiclePerTick: Double;
    property FacilityCapturePointsPerVehiclePerTick: Double read GetFacilityCapturePointsPerVehiclePerTick;
    function GetFacilityWidth: Double;
    property FacilityWidth: Double read GetFacilityWidth;
    function GetFacilityHeight: Double;
    property FacilityHeight: Double read GetFacilityHeight;
    function GetBaseTacticalNuclearStrikeCooldown: LongInt;
    property BaseTacticalNuclearStrikeCooldown: LongInt read GetBaseTacticalNuclearStrikeCooldown;
    function GetTacticalNuclearStrikeCooldownDecreasePerControlCenter: LongInt;
    property TacticalNuclearStrikeCooldownDecreasePerControlCenter: LongInt read GetTacticalNuclearStrikeCooldownDecreasePerControlCenter;
    function GetMaxTacticalNuclearStrikeDamage: Double;
    property MaxTacticalNuclearStrikeDamage: Double read GetMaxTacticalNuclearStrikeDamage;
    function GetTacticalNuclearStrikeRadius: Double;
    property TacticalNuclearStrikeRadius: Double read GetTacticalNuclearStrikeRadius;
    function GetTacticalNuclearStrikeDelay: LongInt;
    property TacticalNuclearStrikeDelay: LongInt read GetTacticalNuclearStrikeDelay;

    destructor Destroy; override;

  end;

  TGameArray = array of TGame;

implementation

constructor TGame.Create(const randomSeed: Int64; const tickCount: LongInt; const worldWidth: Double;
  const worldHeight: Double; const fogOfWarEnabled: Boolean; const victoryScore: LongInt;
  const facilityCaptureScore: LongInt; const vehicleEliminationScore: LongInt; const actionDetectionInterval: LongInt;
  const baseActionCount: LongInt; const additionalActionCountPerControlCenter: LongInt; const maxUnitGroup: LongInt;
  const terrainWeatherMapColumnCount: LongInt; const terrainWeatherMapRowCount: LongInt;
  const plainTerrainVisionFactor: Double; const plainTerrainStealthFactor: Double;
  const plainTerrainSpeedFactor: Double; const swampTerrainVisionFactor: Double;
  const swampTerrainStealthFactor: Double; const swampTerrainSpeedFactor: Double;
  const forestTerrainVisionFactor: Double; const forestTerrainStealthFactor: Double;
  const forestTerrainSpeedFactor: Double; const clearWeatherVisionFactor: Double;
  const clearWeatherStealthFactor: Double; const clearWeatherSpeedFactor: Double;
  const cloudWeatherVisionFactor: Double; const cloudWeatherStealthFactor: Double;
  const cloudWeatherSpeedFactor: Double; const rainWeatherVisionFactor: Double; const rainWeatherStealthFactor: Double;
  const rainWeatherSpeedFactor: Double; const vehicleRadius: Double; const tankDurability: LongInt;
  const tankSpeed: Double; const tankVisionRange: Double; const tankGroundAttackRange: Double;
  const tankAerialAttackRange: Double; const tankGroundDamage: LongInt; const tankAerialDamage: LongInt;
  const tankGroundDefence: LongInt; const tankAerialDefence: LongInt; const tankAttackCooldownTicks: LongInt;
  const tankProductionCost: LongInt; const ifvDurability: LongInt; const ifvSpeed: Double; const ifvVisionRange: Double;
  const ifvGroundAttackRange: Double; const ifvAerialAttackRange: Double; const ifvGroundDamage: LongInt;
  const ifvAerialDamage: LongInt; const ifvGroundDefence: LongInt; const ifvAerialDefence: LongInt;
  const ifvAttackCooldownTicks: LongInt; const ifvProductionCost: LongInt; const arrvDurability: LongInt;
  const arrvSpeed: Double; const arrvVisionRange: Double; const arrvGroundDefence: LongInt;
  const arrvAerialDefence: LongInt; const arrvProductionCost: LongInt; const arrvRepairRange: Double;
  const arrvRepairSpeed: Double; const helicopterDurability: LongInt; const helicopterSpeed: Double;
  const helicopterVisionRange: Double; const helicopterGroundAttackRange: Double;
  const helicopterAerialAttackRange: Double; const helicopterGroundDamage: LongInt;
  const helicopterAerialDamage: LongInt; const helicopterGroundDefence: LongInt; const helicopterAerialDefence: LongInt;
  const helicopterAttackCooldownTicks: LongInt; const helicopterProductionCost: LongInt;
  const fighterDurability: LongInt; const fighterSpeed: Double; const fighterVisionRange: Double;
  const fighterGroundAttackRange: Double; const fighterAerialAttackRange: Double; const fighterGroundDamage: LongInt;
  const fighterAerialDamage: LongInt; const fighterGroundDefence: LongInt; const fighterAerialDefence: LongInt;
  const fighterAttackCooldownTicks: LongInt; const fighterProductionCost: LongInt;
  const maxFacilityCapturePoints: Double; const facilityCapturePointsPerVehiclePerTick: Double;
  const facilityWidth: Double; const facilityHeight: Double; const baseTacticalNuclearStrikeCooldown: LongInt;
  const tacticalNuclearStrikeCooldownDecreasePerControlCenter: LongInt; const maxTacticalNuclearStrikeDamage: Double;
  const tacticalNuclearStrikeRadius: Double; const tacticalNuclearStrikeDelay: LongInt);
begin
  FRandomSeed := randomSeed;
  FTickCount := tickCount;
  FWorldWidth := worldWidth;
  FWorldHeight := worldHeight;
  FFogOfWarEnabled := fogOfWarEnabled;
  FVictoryScore := victoryScore;
  FFacilityCaptureScore := facilityCaptureScore;
  FVehicleEliminationScore := vehicleEliminationScore;
  FActionDetectionInterval := actionDetectionInterval;
  FBaseActionCount := baseActionCount;
  FAdditionalActionCountPerControlCenter := additionalActionCountPerControlCenter;
  FMaxUnitGroup := maxUnitGroup;
  FTerrainWeatherMapColumnCount := terrainWeatherMapColumnCount;
  FTerrainWeatherMapRowCount := terrainWeatherMapRowCount;
  FPlainTerrainVisionFactor := plainTerrainVisionFactor;
  FPlainTerrainStealthFactor := plainTerrainStealthFactor;
  FPlainTerrainSpeedFactor := plainTerrainSpeedFactor;
  FSwampTerrainVisionFactor := swampTerrainVisionFactor;
  FSwampTerrainStealthFactor := swampTerrainStealthFactor;
  FSwampTerrainSpeedFactor := swampTerrainSpeedFactor;
  FForestTerrainVisionFactor := forestTerrainVisionFactor;
  FForestTerrainStealthFactor := forestTerrainStealthFactor;
  FForestTerrainSpeedFactor := forestTerrainSpeedFactor;
  FClearWeatherVisionFactor := clearWeatherVisionFactor;
  FClearWeatherStealthFactor := clearWeatherStealthFactor;
  FClearWeatherSpeedFactor := clearWeatherSpeedFactor;
  FCloudWeatherVisionFactor := cloudWeatherVisionFactor;
  FCloudWeatherStealthFactor := cloudWeatherStealthFactor;
  FCloudWeatherSpeedFactor := cloudWeatherSpeedFactor;
  FRainWeatherVisionFactor := rainWeatherVisionFactor;
  FRainWeatherStealthFactor := rainWeatherStealthFactor;
  FRainWeatherSpeedFactor := rainWeatherSpeedFactor;
  FVehicleRadius := vehicleRadius;
  FTankDurability := tankDurability;
  FTankSpeed := tankSpeed;
  FTankVisionRange := tankVisionRange;
  FTankGroundAttackRange := tankGroundAttackRange;
  FTankAerialAttackRange := tankAerialAttackRange;
  FTankGroundDamage := tankGroundDamage;
  FTankAerialDamage := tankAerialDamage;
  FTankGroundDefence := tankGroundDefence;
  FTankAerialDefence := tankAerialDefence;
  FTankAttackCooldownTicks := tankAttackCooldownTicks;
  FTankProductionCost := tankProductionCost;
  FIfvDurability := ifvDurability;
  FIfvSpeed := ifvSpeed;
  FIfvVisionRange := ifvVisionRange;
  FIfvGroundAttackRange := ifvGroundAttackRange;
  FIfvAerialAttackRange := ifvAerialAttackRange;
  FIfvGroundDamage := ifvGroundDamage;
  FIfvAerialDamage := ifvAerialDamage;
  FIfvGroundDefence := ifvGroundDefence;
  FIfvAerialDefence := ifvAerialDefence;
  FIfvAttackCooldownTicks := ifvAttackCooldownTicks;
  FIfvProductionCost := ifvProductionCost;
  FArrvDurability := arrvDurability;
  FArrvSpeed := arrvSpeed;
  FArrvVisionRange := arrvVisionRange;
  FArrvGroundDefence := arrvGroundDefence;
  FArrvAerialDefence := arrvAerialDefence;
  FArrvProductionCost := arrvProductionCost;
  FArrvRepairRange := arrvRepairRange;
  FArrvRepairSpeed := arrvRepairSpeed;
  FHelicopterDurability := helicopterDurability;
  FHelicopterSpeed := helicopterSpeed;
  FHelicopterVisionRange := helicopterVisionRange;
  FHelicopterGroundAttackRange := helicopterGroundAttackRange;
  FHelicopterAerialAttackRange := helicopterAerialAttackRange;
  FHelicopterGroundDamage := helicopterGroundDamage;
  FHelicopterAerialDamage := helicopterAerialDamage;
  FHelicopterGroundDefence := helicopterGroundDefence;
  FHelicopterAerialDefence := helicopterAerialDefence;
  FHelicopterAttackCooldownTicks := helicopterAttackCooldownTicks;
  FHelicopterProductionCost := helicopterProductionCost;
  FFighterDurability := fighterDurability;
  FFighterSpeed := fighterSpeed;
  FFighterVisionRange := fighterVisionRange;
  FFighterGroundAttackRange := fighterGroundAttackRange;
  FFighterAerialAttackRange := fighterAerialAttackRange;
  FFighterGroundDamage := fighterGroundDamage;
  FFighterAerialDamage := fighterAerialDamage;
  FFighterGroundDefence := fighterGroundDefence;
  FFighterAerialDefence := fighterAerialDefence;
  FFighterAttackCooldownTicks := fighterAttackCooldownTicks;
  FFighterProductionCost := fighterProductionCost;
  FMaxFacilityCapturePoints := maxFacilityCapturePoints;
  FFacilityCapturePointsPerVehiclePerTick := facilityCapturePointsPerVehiclePerTick;
  FFacilityWidth := facilityWidth;
  FFacilityHeight := facilityHeight;
  FBaseTacticalNuclearStrikeCooldown := baseTacticalNuclearStrikeCooldown;
  FTacticalNuclearStrikeCooldownDecreasePerControlCenter := tacticalNuclearStrikeCooldownDecreasePerControlCenter;
  FMaxTacticalNuclearStrikeDamage := maxTacticalNuclearStrikeDamage;
  FTacticalNuclearStrikeRadius := tacticalNuclearStrikeRadius;
  FTacticalNuclearStrikeDelay := tacticalNuclearStrikeDelay;
end;

function TGame.GetRandomSeed: Int64;
begin
  result := FRandomSeed;
end;

function TGame.GetTickCount: LongInt;
begin
  result := FTickCount;
end;

function TGame.GetWorldWidth: Double;
begin
  result := FWorldWidth;
end;

function TGame.GetWorldHeight: Double;
begin
  result := FWorldHeight;
end;

function TGame.GetFogOfWarEnabled: Boolean;
begin
  result := FFogOfWarEnabled;
end;

function TGame.GetVictoryScore: LongInt;
begin
  result := FVictoryScore;
end;

function TGame.GetFacilityCaptureScore: LongInt;
begin
  result := FFacilityCaptureScore;
end;

function TGame.GetVehicleEliminationScore: LongInt;
begin
  result := FVehicleEliminationScore;
end;

function TGame.GetActionDetectionInterval: LongInt;
begin
  result := FActionDetectionInterval;
end;

function TGame.GetBaseActionCount: LongInt;
begin
  result := FBaseActionCount;
end;

function TGame.GetAdditionalActionCountPerControlCenter: LongInt;
begin
  result := FAdditionalActionCountPerControlCenter;
end;

function TGame.GetMaxUnitGroup: LongInt;
begin
  result := FMaxUnitGroup;
end;

function TGame.GetTerrainWeatherMapColumnCount: LongInt;
begin
  result := FTerrainWeatherMapColumnCount;
end;

function TGame.GetTerrainWeatherMapRowCount: LongInt;
begin
  result := FTerrainWeatherMapRowCount;
end;

function TGame.GetPlainTerrainVisionFactor: Double;
begin
  result := FPlainTerrainVisionFactor;
end;

function TGame.GetPlainTerrainStealthFactor: Double;
begin
  result := FPlainTerrainStealthFactor;
end;

function TGame.GetPlainTerrainSpeedFactor: Double;
begin
  result := FPlainTerrainSpeedFactor;
end;

function TGame.GetSwampTerrainVisionFactor: Double;
begin
  result := FSwampTerrainVisionFactor;
end;

function TGame.GetSwampTerrainStealthFactor: Double;
begin
  result := FSwampTerrainStealthFactor;
end;

function TGame.GetSwampTerrainSpeedFactor: Double;
begin
  result := FSwampTerrainSpeedFactor;
end;

function TGame.GetForestTerrainVisionFactor: Double;
begin
  result := FForestTerrainVisionFactor;
end;

function TGame.GetForestTerrainStealthFactor: Double;
begin
  result := FForestTerrainStealthFactor;
end;

function TGame.GetForestTerrainSpeedFactor: Double;
begin
  result := FForestTerrainSpeedFactor;
end;

function TGame.GetClearWeatherVisionFactor: Double;
begin
  result := FClearWeatherVisionFactor;
end;

function TGame.GetClearWeatherStealthFactor: Double;
begin
  result := FClearWeatherStealthFactor;
end;

function TGame.GetClearWeatherSpeedFactor: Double;
begin
  result := FClearWeatherSpeedFactor;
end;

function TGame.GetCloudWeatherVisionFactor: Double;
begin
  result := FCloudWeatherVisionFactor;
end;

function TGame.GetCloudWeatherStealthFactor: Double;
begin
  result := FCloudWeatherStealthFactor;
end;

function TGame.GetCloudWeatherSpeedFactor: Double;
begin
  result := FCloudWeatherSpeedFactor;
end;

function TGame.GetRainWeatherVisionFactor: Double;
begin
  result := FRainWeatherVisionFactor;
end;

function TGame.GetRainWeatherStealthFactor: Double;
begin
  result := FRainWeatherStealthFactor;
end;

function TGame.GetRainWeatherSpeedFactor: Double;
begin
  result := FRainWeatherSpeedFactor;
end;

function TGame.GetVehicleRadius: Double;
begin
  result := FVehicleRadius;
end;

function TGame.GetTankDurability: LongInt;
begin
  result := FTankDurability;
end;

function TGame.GetTankSpeed: Double;
begin
  result := FTankSpeed;
end;

function TGame.GetTankVisionRange: Double;
begin
  result := FTankVisionRange;
end;

function TGame.GetTankGroundAttackRange: Double;
begin
  result := FTankGroundAttackRange;
end;

function TGame.GetTankAerialAttackRange: Double;
begin
  result := FTankAerialAttackRange;
end;

function TGame.GetTankGroundDamage: LongInt;
begin
  result := FTankGroundDamage;
end;

function TGame.GetTankAerialDamage: LongInt;
begin
  result := FTankAerialDamage;
end;

function TGame.GetTankGroundDefence: LongInt;
begin
  result := FTankGroundDefence;
end;

function TGame.GetTankAerialDefence: LongInt;
begin
  result := FTankAerialDefence;
end;

function TGame.GetTankAttackCooldownTicks: LongInt;
begin
  result := FTankAttackCooldownTicks;
end;

function TGame.GetTankProductionCost: LongInt;
begin
  result := FTankProductionCost;
end;

function TGame.GetIfvDurability: LongInt;
begin
  result := FIfvDurability;
end;

function TGame.GetIfvSpeed: Double;
begin
  result := FIfvSpeed;
end;

function TGame.GetIfvVisionRange: Double;
begin
  result := FIfvVisionRange;
end;

function TGame.GetIfvGroundAttackRange: Double;
begin
  result := FIfvGroundAttackRange;
end;

function TGame.GetIfvAerialAttackRange: Double;
begin
  result := FIfvAerialAttackRange;
end;

function TGame.GetIfvGroundDamage: LongInt;
begin
  result := FIfvGroundDamage;
end;

function TGame.GetIfvAerialDamage: LongInt;
begin
  result := FIfvAerialDamage;
end;

function TGame.GetIfvGroundDefence: LongInt;
begin
  result := FIfvGroundDefence;
end;

function TGame.GetIfvAerialDefence: LongInt;
begin
  result := FIfvAerialDefence;
end;

function TGame.GetIfvAttackCooldownTicks: LongInt;
begin
  result := FIfvAttackCooldownTicks;
end;

function TGame.GetIfvProductionCost: LongInt;
begin
  result := FIfvProductionCost;
end;

function TGame.GetArrvDurability: LongInt;
begin
  result := FArrvDurability;
end;

function TGame.GetArrvSpeed: Double;
begin
  result := FArrvSpeed;
end;

function TGame.GetArrvVisionRange: Double;
begin
  result := FArrvVisionRange;
end;

function TGame.GetArrvGroundDefence: LongInt;
begin
  result := FArrvGroundDefence;
end;

function TGame.GetArrvAerialDefence: LongInt;
begin
  result := FArrvAerialDefence;
end;

function TGame.GetArrvProductionCost: LongInt;
begin
  result := FArrvProductionCost;
end;

function TGame.GetArrvRepairRange: Double;
begin
  result := FArrvRepairRange;
end;

function TGame.GetArrvRepairSpeed: Double;
begin
  result := FArrvRepairSpeed;
end;

function TGame.GetHelicopterDurability: LongInt;
begin
  result := FHelicopterDurability;
end;

function TGame.GetHelicopterSpeed: Double;
begin
  result := FHelicopterSpeed;
end;

function TGame.GetHelicopterVisionRange: Double;
begin
  result := FHelicopterVisionRange;
end;

function TGame.GetHelicopterGroundAttackRange: Double;
begin
  result := FHelicopterGroundAttackRange;
end;

function TGame.GetHelicopterAerialAttackRange: Double;
begin
  result := FHelicopterAerialAttackRange;
end;

function TGame.GetHelicopterGroundDamage: LongInt;
begin
  result := FHelicopterGroundDamage;
end;

function TGame.GetHelicopterAerialDamage: LongInt;
begin
  result := FHelicopterAerialDamage;
end;

function TGame.GetHelicopterGroundDefence: LongInt;
begin
  result := FHelicopterGroundDefence;
end;

function TGame.GetHelicopterAerialDefence: LongInt;
begin
  result := FHelicopterAerialDefence;
end;

function TGame.GetHelicopterAttackCooldownTicks: LongInt;
begin
  result := FHelicopterAttackCooldownTicks;
end;

function TGame.GetHelicopterProductionCost: LongInt;
begin
  result := FHelicopterProductionCost;
end;

function TGame.GetFighterDurability: LongInt;
begin
  result := FFighterDurability;
end;

function TGame.GetFighterSpeed: Double;
begin
  result := FFighterSpeed;
end;

function TGame.GetFighterVisionRange: Double;
begin
  result := FFighterVisionRange;
end;

function TGame.GetFighterGroundAttackRange: Double;
begin
  result := FFighterGroundAttackRange;
end;

function TGame.GetFighterAerialAttackRange: Double;
begin
  result := FFighterAerialAttackRange;
end;

function TGame.GetFighterGroundDamage: LongInt;
begin
  result := FFighterGroundDamage;
end;

function TGame.GetFighterAerialDamage: LongInt;
begin
  result := FFighterAerialDamage;
end;

function TGame.GetFighterGroundDefence: LongInt;
begin
  result := FFighterGroundDefence;
end;

function TGame.GetFighterAerialDefence: LongInt;
begin
  result := FFighterAerialDefence;
end;

function TGame.GetFighterAttackCooldownTicks: LongInt;
begin
  result := FFighterAttackCooldownTicks;
end;

function TGame.GetFighterProductionCost: LongInt;
begin
  result := FFighterProductionCost;
end;

function TGame.GetMaxFacilityCapturePoints: Double;
begin
  result := FMaxFacilityCapturePoints;
end;

function TGame.GetFacilityCapturePointsPerVehiclePerTick: Double;
begin
  result := FFacilityCapturePointsPerVehiclePerTick;
end;

function TGame.GetFacilityWidth: Double;
begin
  result := FFacilityWidth;
end;

function TGame.GetFacilityHeight: Double;
begin
  result := FFacilityHeight;
end;

function TGame.GetBaseTacticalNuclearStrikeCooldown: LongInt;
begin
  result := FBaseTacticalNuclearStrikeCooldown;
end;

function TGame.GetTacticalNuclearStrikeCooldownDecreasePerControlCenter: LongInt;
begin
  result := FTacticalNuclearStrikeCooldownDecreasePerControlCenter;
end;

function TGame.GetMaxTacticalNuclearStrikeDamage: Double;
begin
  result := FMaxTacticalNuclearStrikeDamage;
end;

function TGame.GetTacticalNuclearStrikeRadius: Double;
begin
  result := FTacticalNuclearStrikeRadius;
end;

function TGame.GetTacticalNuclearStrikeDelay: LongInt;
begin
  result := FTacticalNuclearStrikeDelay;
end;

destructor TGame.Destroy;
begin
  inherited;
end;

end.
