unit UnitControl;

interface

uses
  Math, TypeControl;

type
  TUnit = class
  private
    FId: Int64;
    FX: Double;
    FY: Double;

  protected
    constructor Create(const id: Int64; const x: Double; const y: Double);

  public
    function GetId: Int64;
    property Id: Int64 read GetId;
    function GetX: Double;
    property X: Double read GetX;
    function GetY: Double;
    property Y: Double read GetY;

    function GetDistanceTo(x: Double; y: Double): Double; overload;
    function GetDistanceTo(otherUnit: TUnit): Double; overload;

    destructor Destroy; override;

  end;

  TUnitArray = array of TUnit;

implementation

constructor TUnit.Create(const id: Int64; const x: Double; const y: Double);
begin
  FId := id;
  FX := x;
  FY := y;
end;

function TUnit.GetId: Int64;
begin
  result := FId;
end;

function TUnit.GetX: Double;
begin
  result := FX;
end;

function TUnit.GetY: Double;
begin
  result := FY;
end;

function TUnit.getDistanceTo(x: Double; y: Double): Double;
begin
  result := Sqrt(Sqr(FX - x) + Sqr(FY - y));
end;

function TUnit.getDistanceTo(otherUnit: TUnit): Double;
begin
  result := GetDistanceTo(otherUnit.FX, otherUnit.FY);
end;

destructor TUnit.Destroy;
begin
  inherited;
end;

end.
