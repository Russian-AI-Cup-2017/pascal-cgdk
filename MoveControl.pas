unit MoveControl;

interface

uses
  Math, TypeControl, ActionTypeControl, VehicleTypeControl;

type
  TMove = class
  private
    FAction: TActionType;
    FGroup: LongInt;
    FLeft: Double;
    FTop: Double;
    FRight: Double;
    FBottom: Double;
    FX: Double;
    FY: Double;
    FAngle: Double;
    FFactor: Double;
    FMaxSpeed: Double;
    FMaxAngularSpeed: Double;
    FVehicleType: TVehicleType;
    FFacilityId: Int64;

  public
    constructor Create;

    function GetAction: TActionType;
    procedure SetAction(action: TActionType);
    property Action: TActionType read GetAction write SetAction;
    function GetGroup: LongInt;
    procedure SetGroup(group: LongInt);
    property Group: LongInt read GetGroup write SetGroup;
    function GetLeft: Double;
    procedure SetLeft(left: Double);
    property Left: Double read GetLeft write SetLeft;
    function GetTop: Double;
    procedure SetTop(top: Double);
    property Top: Double read GetTop write SetTop;
    function GetRight: Double;
    procedure SetRight(right: Double);
    property Right: Double read GetRight write SetRight;
    function GetBottom: Double;
    procedure SetBottom(bottom: Double);
    property Bottom: Double read GetBottom write SetBottom;
    function GetX: Double;
    procedure SetX(x: Double);
    property X: Double read GetX write SetX;
    function GetY: Double;
    procedure SetY(y: Double);
    property Y: Double read GetY write SetY;
    function GetAngle: Double;
    procedure SetAngle(angle: Double);
    property Angle: Double read GetAngle write SetAngle;
    function GetFactor: Double;
    procedure SetFactor(factor: Double);
    property Factor: Double read GetFactor write SetFactor;
    function GetMaxSpeed: Double;
    procedure SetMaxSpeed(maxSpeed: Double);
    property MaxSpeed: Double read GetMaxSpeed write SetMaxSpeed;
    function GetMaxAngularSpeed: Double;
    procedure SetMaxAngularSpeed(maxAngularSpeed: Double);
    property MaxAngularSpeed: Double read GetMaxAngularSpeed write SetMaxAngularSpeed;
    function GetVehicleType: TVehicleType;
    procedure SetVehicleType(vehicleType: TVehicleType);
    property VehicleType: TVehicleType read GetVehicleType write SetVehicleType;
    function GetFacilityId: Int64;
    procedure SetFacilityId(facilityId: Int64);
    property FacilityId: Int64 read GetFacilityId write SetFacilityId;

    destructor Destroy; override;

  end;

  TMoveArray = array of TMove;

implementation

constructor TMove.Create;
begin
  FAction := _ACTION_UNKNOWN_;
  FGroup := 0;
  FLeft := 0.0;
  FTop := 0.0;
  FRight := 0.0;
  FBottom := 0.0;
  FX := 0.0;
  FY := 0.0;
  FAngle := 0.0;
  FFactor := 0.0;
  FMaxSpeed := 0.0;
  FMaxAngularSpeed := 0.0;
  FVehicleType := _VEHICLE_UNKNOWN_;
  FFacilityId := -1;
end;

function TMove.GetAction: TActionType;
begin
  result := FAction;
end;

procedure TMove.SetAction(action: TActionType);
begin
  FAction := action;
end;

function TMove.GetGroup: LongInt;
begin
  result := FGroup;
end;

procedure TMove.SetGroup(group: LongInt);
begin
  FGroup := group;
end;

function TMove.GetLeft: Double;
begin
  result := FLeft;
end;

procedure TMove.SetLeft(left: Double);
begin
  FLeft := left;
end;

function TMove.GetTop: Double;
begin
  result := FTop;
end;

procedure TMove.SetTop(top: Double);
begin
  FTop := top;
end;

function TMove.GetRight: Double;
begin
  result := FRight;
end;

procedure TMove.SetRight(right: Double);
begin
  FRight := right;
end;

function TMove.GetBottom: Double;
begin
  result := FBottom;
end;

procedure TMove.SetBottom(bottom: Double);
begin
  FBottom := bottom;
end;

function TMove.GetX: Double;
begin
  result := FX;
end;

procedure TMove.SetX(x: Double);
begin
  FX := x;
end;

function TMove.GetY: Double;
begin
  result := FY;
end;

procedure TMove.SetY(y: Double);
begin
  FY := y;
end;

function TMove.GetAngle: Double;
begin
  result := FAngle;
end;

procedure TMove.SetAngle(angle: Double);
begin
  FAngle := angle;
end;

function TMove.GetFactor: Double;
begin
  result := FFactor;
end;

procedure TMove.SetFactor(factor: Double);
begin
  FFactor := factor;
end;

function TMove.GetMaxSpeed: Double;
begin
  result := FMaxSpeed;
end;

procedure TMove.SetMaxSpeed(maxSpeed: Double);
begin
  FMaxSpeed := maxSpeed;
end;

function TMove.GetMaxAngularSpeed: Double;
begin
  result := FMaxAngularSpeed;
end;

procedure TMove.SetMaxAngularSpeed(maxAngularSpeed: Double);
begin
  FMaxAngularSpeed := maxAngularSpeed;
end;

function TMove.GetVehicleType: TVehicleType;
begin
  result := FVehicleType;
end;

procedure TMove.SetVehicleType(vehicleType: TVehicleType);
begin
  FVehicleType := vehicleType;
end;

function TMove.GetFacilityId: Int64;
begin
  result := FFacilityId;
end;

procedure TMove.SetFacilityId(facilityId: Int64);
begin
  FFacilityId := facilityId;
end;

destructor TMove.Destroy;
begin
  inherited;
end;

end.
