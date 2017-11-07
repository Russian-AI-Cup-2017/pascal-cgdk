unit VehicleUpdateControl;

interface

uses
  Math, TypeControl;

type
  TVehicleUpdate = class
  private
    FId: Int64;
    FX: Double;
    FY: Double;
    FDurability: LongInt;
    FRemainingAttackCooldownTicks: LongInt;
    FSelected: Boolean;
    FGroups: TLongIntArray;

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const durability: LongInt;
      const remainingAttackCooldownTicks: LongInt; const selected: Boolean; const groups: TLongIntArray);

    function GetId: Int64;
    property Id: Int64 read GetId;
    function GetX: Double;
    property X: Double read GetX;
    function GetY: Double;
    property Y: Double read GetY;
    function GetDurability: LongInt;
    property Durability: LongInt read GetDurability;
    function GetRemainingAttackCooldownTicks: LongInt;
    property RemainingAttackCooldownTicks: LongInt read GetRemainingAttackCooldownTicks;
    function GetSelected: Boolean;
    property IsSelected: Boolean read GetSelected;
    function GetGroups: TLongIntArray;
    property Groups: TLongIntArray read GetGroups;

    destructor Destroy; override;

  end;

  TVehicleUpdateArray = array of TVehicleUpdate;

implementation

constructor TVehicleUpdate.Create(const id: Int64; const x: Double; const y: Double; const durability: LongInt;
  const remainingAttackCooldownTicks: LongInt; const selected: Boolean; const groups: TLongIntArray);
begin
  FId := id;
  FX := x;
  FY := y;
  FDurability := durability;
  FRemainingAttackCooldownTicks := remainingAttackCooldownTicks;
  FSelected := selected;
  if Assigned(groups) then begin
    FGroups := Copy(groups, 0, Length(groups));
  end else begin
    FGroups := nil;
  end;
end;

function TVehicleUpdate.GetId: Int64;
begin
  result := FId;
end;

function TVehicleUpdate.GetX: Double;
begin
  result := FX;
end;

function TVehicleUpdate.GetY: Double;
begin
  result := FY;
end;

function TVehicleUpdate.GetDurability: LongInt;
begin
  result := FDurability;
end;

function TVehicleUpdate.GetRemainingAttackCooldownTicks: LongInt;
begin
  result := FRemainingAttackCooldownTicks;
end;

function TVehicleUpdate.GetSelected: Boolean;
begin
  result := FSelected;
end;

function TVehicleUpdate.GetGroups: TLongIntArray;
begin
  if Assigned(FGroups) then begin
    result := Copy(FGroups, 0, Length(FGroups));
  end else begin
    result := nil;
  end;
end;

destructor TVehicleUpdate.Destroy;
begin
  inherited;
end;

end.
