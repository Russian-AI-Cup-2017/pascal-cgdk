unit VehicleControl;

interface

uses
  Math, TypeControl, CircularUnitControl, VehicleTypeControl, VehicleUpdateControl;

type
  TVehicle = class (TCircularUnit)
  private
    FPlayerId: Int64;
    FDurability: LongInt;
    FMaxDurability: LongInt;
    FMaxSpeed: Double;
    FVisionRange: Double;
    FSquaredVisionRange: Double;
    FGroundAttackRange: Double;
    FSquaredGroundAttackRange: Double;
    FAerialAttackRange: Double;
    FSquaredAerialAttackRange: Double;
    FGroundDamage: LongInt;
    FAerialDamage: LongInt;
    FGroundDefence: LongInt;
    FAerialDefence: LongInt;
    FAttackCooldownTicks: LongInt;
    FRemainingAttackCooldownTicks: LongInt;
    FType: TVehicleType;
    FAerial: Boolean;
    FSelected: Boolean;
    FGroups: TLongIntArray;

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const radius: Double; const playerId: Int64;
      const durability: LongInt; const maxDurability: LongInt; const maxSpeed: Double; const visionRange: Double;
      const squaredVisionRange: Double; const groundAttackRange: Double; const squaredGroundAttackRange: Double;
      const aerialAttackRange: Double; const squaredAerialAttackRange: Double; const groundDamage: LongInt;
      const aerialDamage: LongInt; const groundDefence: LongInt; const aerialDefence: LongInt;
      const attackCooldownTicks: LongInt; const remainingAttackCooldownTicks: LongInt; const vehicleType: TVehicleType;
      const aerial: Boolean; const selected: Boolean; const groups: TLongIntArray); overload;
    constructor Create(const vehicle: TVehicle; const vehicleUpdate: TVehicleUpdate); overload;

    function GetPlayerId: Int64;
    property PlayerId: Int64 read GetPlayerId;
    function GetDurability: LongInt;
    property Durability: LongInt read GetDurability;
    function GetMaxDurability: LongInt;
    property MaxDurability: LongInt read GetMaxDurability;
    function GetMaxSpeed: Double;
    property MaxSpeed: Double read GetMaxSpeed;
    function GetVisionRange: Double;
    property VisionRange: Double read GetVisionRange;
    function GetSquaredVisionRange: Double;
    property SquaredVisionRange: Double read GetSquaredVisionRange;
    function GetGroundAttackRange: Double;
    property GroundAttackRange: Double read GetGroundAttackRange;
    function GetSquaredGroundAttackRange: Double;
    property SquaredGroundAttackRange: Double read GetSquaredGroundAttackRange;
    function GetAerialAttackRange: Double;
    property AerialAttackRange: Double read GetAerialAttackRange;
    function GetSquaredAerialAttackRange: Double;
    property SquaredAerialAttackRange: Double read GetSquaredAerialAttackRange;
    function GetGroundDamage: LongInt;
    property GroundDamage: LongInt read GetGroundDamage;
    function GetAerialDamage: LongInt;
    property AerialDamage: LongInt read GetAerialDamage;
    function GetGroundDefence: LongInt;
    property GroundDefence: LongInt read GetGroundDefence;
    function GetAerialDefence: LongInt;
    property AerialDefence: LongInt read GetAerialDefence;
    function GetAttackCooldownTicks: LongInt;
    property AttackCooldownTicks: LongInt read GetAttackCooldownTicks;
    function GetRemainingAttackCooldownTicks: LongInt;
    property RemainingAttackCooldownTicks: LongInt read GetRemainingAttackCooldownTicks;
    function GetType: TVehicleType;
    property VehicleType: TVehicleType read GetType;
    function GetAerial: Boolean;
    property IsAerial: Boolean read GetAerial;
    function GetSelected: Boolean;
    property IsSelected: Boolean read GetSelected;
    function GetGroups: TLongIntArray;
    property Groups: TLongIntArray read GetGroups;

    destructor Destroy; override;

  end;

  TVehicleArray = array of TVehicle;

implementation

constructor TVehicle.Create(const id: Int64; const x: Double; const y: Double; const radius: Double;
  const playerId: Int64; const durability: LongInt; const maxDurability: LongInt; const maxSpeed: Double;
  const visionRange: Double; const squaredVisionRange: Double; const groundAttackRange: Double;
  const squaredGroundAttackRange: Double; const aerialAttackRange: Double; const squaredAerialAttackRange: Double;
  const groundDamage: LongInt; const aerialDamage: LongInt; const groundDefence: LongInt; const aerialDefence: LongInt;
  const attackCooldownTicks: LongInt; const remainingAttackCooldownTicks: LongInt; const vehicleType: TVehicleType;
  const aerial: Boolean; const selected: Boolean; const groups: TLongIntArray);
begin
  inherited Create(id, x, y, radius);

  FPlayerId := playerId;
  FDurability := durability;
  FMaxDurability := maxDurability;
  FMaxSpeed := maxSpeed;
  FVisionRange := visionRange;
  FSquaredVisionRange := squaredVisionRange;
  FGroundAttackRange := groundAttackRange;
  FSquaredGroundAttackRange := squaredGroundAttackRange;
  FAerialAttackRange := aerialAttackRange;
  FSquaredAerialAttackRange := squaredAerialAttackRange;
  FGroundDamage := groundDamage;
  FAerialDamage := aerialDamage;
  FGroundDefence := groundDefence;
  FAerialDefence := aerialDefence;
  FAttackCooldownTicks := attackCooldownTicks;
  FRemainingAttackCooldownTicks := remainingAttackCooldownTicks;
  FType := vehicleType;
  FAerial := aerial;
  FSelected := selected;
  if Assigned(groups) then begin
    FGroups := Copy(groups, 0, Length(groups));
  end else begin
    FGroups := nil;
  end;
end;

constructor TVehicle.Create(const vehicle: TVehicle; const vehicleUpdate: TVehicleUpdate);
begin
  inherited Create(vehicle.Id, vehicleUpdate.X, vehicleUpdate.Y, vehicle.Radius);

  FPlayerId := vehicle.PlayerId;
  FDurability := vehicleUpdate.Durability;
  FMaxDurability := vehicle.MaxDurability;
  FMaxSpeed := vehicle.MaxSpeed;
  FVisionRange := vehicle.VisionRange;
  FSquaredVisionRange := vehicle.SquaredVisionRange;
  FGroundAttackRange := vehicle.GroundAttackRange;
  FSquaredGroundAttackRange := vehicle.SquaredGroundAttackRange;
  FAerialAttackRange := vehicle.AerialAttackRange;
  FSquaredAerialAttackRange := vehicle.SquaredAerialAttackRange;
  FGroundDamage := vehicle.GroundDamage;
  FAerialDamage := vehicle.AerialDamage;
  FGroundDefence := vehicle.GroundDefence;
  FAerialDefence := vehicle.AerialDefence;
  FAttackCooldownTicks := vehicle.AttackCooldownTicks;
  FRemainingAttackCooldownTicks := vehicleUpdate.RemainingAttackCooldownTicks;
  FType := vehicle.VehicleType;
  FAerial := vehicle.IsAerial;
  FSelected := vehicleUpdate.IsSelected;
  FGroups := vehicleUpdate.Groups;
end;

function TVehicle.GetPlayerId: Int64;
begin
  result := FPlayerId;
end;

function TVehicle.GetDurability: LongInt;
begin
  result := FDurability;
end;

function TVehicle.GetMaxDurability: LongInt;
begin
  result := FMaxDurability;
end;

function TVehicle.GetMaxSpeed: Double;
begin
  result := FMaxSpeed;
end;

function TVehicle.GetVisionRange: Double;
begin
  result := FVisionRange;
end;

function TVehicle.GetSquaredVisionRange: Double;
begin
  result := FSquaredVisionRange;
end;

function TVehicle.GetGroundAttackRange: Double;
begin
  result := FGroundAttackRange;
end;

function TVehicle.GetSquaredGroundAttackRange: Double;
begin
  result := FSquaredGroundAttackRange;
end;

function TVehicle.GetAerialAttackRange: Double;
begin
  result := FAerialAttackRange;
end;

function TVehicle.GetSquaredAerialAttackRange: Double;
begin
  result := FSquaredAerialAttackRange;
end;

function TVehicle.GetGroundDamage: LongInt;
begin
  result := FGroundDamage;
end;

function TVehicle.GetAerialDamage: LongInt;
begin
  result := FAerialDamage;
end;

function TVehicle.GetGroundDefence: LongInt;
begin
  result := FGroundDefence;
end;

function TVehicle.GetAerialDefence: LongInt;
begin
  result := FAerialDefence;
end;

function TVehicle.GetAttackCooldownTicks: LongInt;
begin
  result := FAttackCooldownTicks;
end;

function TVehicle.GetRemainingAttackCooldownTicks: LongInt;
begin
  result := FRemainingAttackCooldownTicks;
end;

function TVehicle.GetType: TVehicleType;
begin
  result := FType;
end;

function TVehicle.GetAerial: Boolean;
begin
  result := FAerial;
end;

function TVehicle.GetSelected: Boolean;
begin
  result := FSelected;
end;

function TVehicle.GetGroups: TLongIntArray;
begin
  if Assigned(FGroups) then begin
    result := Copy(FGroups, 0, Length(FGroups));
  end else begin
    result := nil;
  end;
end;

destructor TVehicle.Destroy;
begin
  inherited;
end;

end.
