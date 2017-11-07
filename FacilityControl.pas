unit FacilityControl;

interface

uses
  Math, TypeControl, FacilityTypeControl, VehicleTypeControl;

type
  TFacility = class
  private
    FId: Int64;
    FType: TFacilityType;
    FOwnerPlayerId: Int64;
    FLeft: Double;
    FTop: Double;
    FCapturePoints: Double;
    FVehicleType: TVehicleType;
    FProductionProgress: LongInt;

  public
    constructor Create(const id: Int64; const facilityType: TFacilityType; const ownerPlayerId: Int64;
      const left: Double; const top: Double; const capturePoints: Double; const vehicleType: TVehicleType;
      const productionProgress: LongInt); overload;
    constructor Create(const facility: TFacility); overload;

    function GetId: Int64;
    property Id: Int64 read GetId;
    function GetType: TFacilityType;
    property FacilityType: TFacilityType read GetType;
    function GetOwnerPlayerId: Int64;
    property OwnerPlayerId: Int64 read GetOwnerPlayerId;
    function GetLeft: Double;
    property Left: Double read GetLeft;
    function GetTop: Double;
    property Top: Double read GetTop;
    function GetCapturePoints: Double;
    property CapturePoints: Double read GetCapturePoints;
    function GetVehicleType: TVehicleType;
    property VehicleType: TVehicleType read GetVehicleType;
    function GetProductionProgress: LongInt;
    property ProductionProgress: LongInt read GetProductionProgress;

    destructor Destroy; override;

  end;

  TFacilityArray = array of TFacility;

implementation

constructor TFacility.Create(const id: Int64; const facilityType: TFacilityType; const ownerPlayerId: Int64;
  const left: Double; const top: Double; const capturePoints: Double; const vehicleType: TVehicleType;
  const productionProgress: LongInt);
begin
  FId := id;
  FType := facilityType;
  FOwnerPlayerId := ownerPlayerId;
  FLeft := left;
  FTop := top;
  FCapturePoints := capturePoints;
  FVehicleType := vehicleType;
  FProductionProgress := productionProgress;
end;

constructor TFacility.Create(const facility: TFacility); overload;
begin
  FId := facility.Id;
  FType := facility.FacilityType;
  FOwnerPlayerId := facility.OwnerPlayerId;
  FLeft := facility.Left;
  FTop := facility.Top;
  FCapturePoints := facility.CapturePoints;
  FVehicleType := facility.VehicleType;
  FProductionProgress := facility.ProductionProgress;
end;

function TFacility.GetId: Int64;
begin
  result := FId;
end;

function TFacility.GetType: TFacilityType;
begin
  result := FType;
end;

function TFacility.GetOwnerPlayerId: Int64;
begin
  result := FOwnerPlayerId;
end;

function TFacility.GetLeft: Double;
begin
  result := FLeft;
end;

function TFacility.GetTop: Double;
begin
  result := FTop;
end;

function TFacility.GetCapturePoints: Double;
begin
  result := FCapturePoints;
end;

function TFacility.GetVehicleType: TVehicleType;
begin
  result := FVehicleType;
end;

function TFacility.GetProductionProgress: LongInt;
begin
  result := FProductionProgress;
end;

destructor TFacility.Destroy;
begin
  inherited;
end;

end.
