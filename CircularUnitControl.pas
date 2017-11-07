unit CircularUnitControl;

interface

uses
  Math, TypeControl, UnitControl;

type
  TCircularUnit = class (TUnit)
  private
    FRadius: Double;

  protected
    constructor Create(const id: Int64; const x: Double; const y: Double; const radius: Double);

  public
    function GetRadius: Double;
    property Radius: Double read GetRadius;

    destructor Destroy; override;

  end;

  TCircularUnitArray = array of TCircularUnit;

implementation

constructor TCircularUnit.Create(const id: Int64; const x: Double; const y: Double; const radius: Double);
begin
  inherited Create(id, x, y);

  FRadius := radius;
end;

function TCircularUnit.GetRadius: Double;
begin
  result := FRadius;
end;

destructor TCircularUnit.Destroy;
begin
  inherited;
end;

end.
