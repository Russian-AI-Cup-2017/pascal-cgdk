unit WorldControl;

interface

uses
  Math, TypeControl, FacilityControl, PlayerControl, TerrainTypeControl, VehicleControl, VehicleUpdateControl, WeatherTypeControl;

type
  TWorld = class
  private
    FTickIndex: LongInt;
    FTickCount: LongInt;
    FWidth: Double;
    FHeight: Double;
    FPlayers: TPlayerArray;
    FNewVehicles: TVehicleArray;
    FVehicleUpdates: TVehicleUpdateArray;
    FTerrainByCellXY: TTerrainTypeArray2D;
    FWeatherByCellXY: TWeatherTypeArray2D;
    FFacilities: TFacilityArray;

  public
    constructor Create(const tickIndex: LongInt; const tickCount: LongInt; const width: Double; const height: Double;
      const players: TPlayerArray; const newVehicles: TVehicleArray; const vehicleUpdates: TVehicleUpdateArray;
      const terrainByCellXY: TTerrainTypeArray2D; const weatherByCellXY: TWeatherTypeArray2D;
      const facilities: TFacilityArray);

    function GetTickIndex: LongInt;
    property TickIndex: LongInt read GetTickIndex;
    function GetTickCount: LongInt;
    property TickCount: LongInt read GetTickCount;
    function GetWidth: Double;
    property Width: Double read GetWidth;
    function GetHeight: Double;
    property Height: Double read GetHeight;
    function GetPlayers: TPlayerArray;
    property Players: TPlayerArray read GetPlayers;
    function GetNewVehicles: TVehicleArray;
    property NewVehicles: TVehicleArray read GetNewVehicles;
    function GetVehicleUpdates: TVehicleUpdateArray;
    property VehicleUpdates: TVehicleUpdateArray read GetVehicleUpdates;
    function GetTerrainByCellXY: TTerrainTypeArray2D;
    property TerrainByCellXY: TTerrainTypeArray2D read GetTerrainByCellXY;
    function GetWeatherByCellXY: TWeatherTypeArray2D;
    property WeatherByCellXY: TWeatherTypeArray2D read GetWeatherByCellXY;
    function GetFacilities: TFacilityArray;
    property Facilities: TFacilityArray read GetFacilities;

    function GetMyPlayer: TPlayer;
    function GetOpponentPlayer: TPlayer;

    destructor Destroy; override;

  end;

  TWorldArray = array of TWorld;

implementation

constructor TWorld.Create(const tickIndex: LongInt; const tickCount: LongInt; const width: Double; const height: Double;
  const players: TPlayerArray; const newVehicles: TVehicleArray; const vehicleUpdates: TVehicleUpdateArray;
  const terrainByCellXY: TTerrainTypeArray2D; const weatherByCellXY: TWeatherTypeArray2D;
  const facilities: TFacilityArray);
var
  i: LongInt;

begin
  FTickIndex := tickIndex;
  FTickCount := tickCount;
  FWidth := width;
  FHeight := height;
  if Assigned(players) then begin
    FPlayers := Copy(players, 0, Length(players));
  end else begin
    FPlayers := nil;
  end;
  if Assigned(newVehicles) then begin
    FNewVehicles := Copy(newVehicles, 0, Length(newVehicles));
  end else begin
    FNewVehicles := nil;
  end;
  if Assigned(vehicleUpdates) then begin
    FVehicleUpdates := Copy(vehicleUpdates, 0, Length(vehicleUpdates));
  end else begin
    FVehicleUpdates := nil;
  end;
  if Assigned(terrainByCellXY) then begin
    SetLength(FTerrainByCellXY, Length(terrainByCellXY));

    for i := High(terrainByCellXY) downto 0 do begin
      if Assigned(terrainByCellXY[i]) then begin
        FTerrainByCellXY[i] := Copy(terrainByCellXY[i], 0, Length(terrainByCellXY[i]));
      end else begin
        FTerrainByCellXY[i] := nil;
      end;
    end;
  end else begin
    FTerrainByCellXY := nil;
  end;
  if Assigned(weatherByCellXY) then begin
    SetLength(FWeatherByCellXY, Length(weatherByCellXY));

    for i := High(weatherByCellXY) downto 0 do begin
      if Assigned(weatherByCellXY[i]) then begin
        FWeatherByCellXY[i] := Copy(weatherByCellXY[i], 0, Length(weatherByCellXY[i]));
      end else begin
        FWeatherByCellXY[i] := nil;
      end;
    end;
  end else begin
    FWeatherByCellXY := nil;
  end;
  if Assigned(facilities) then begin
    FFacilities := Copy(facilities, 0, Length(facilities));
  end else begin
    FFacilities := nil;
  end;
end;

function TWorld.GetTickIndex: LongInt;
begin
  result := FTickIndex;
end;

function TWorld.GetTickCount: LongInt;
begin
  result := FTickCount;
end;

function TWorld.GetWidth: Double;
begin
  result := FWidth;
end;

function TWorld.GetHeight: Double;
begin
  result := FHeight;
end;

function TWorld.GetPlayers: TPlayerArray;
begin
  if Assigned(FPlayers) then begin
    result := Copy(FPlayers, 0, Length(FPlayers));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetNewVehicles: TVehicleArray;
begin
  if Assigned(FNewVehicles) then begin
    result := Copy(FNewVehicles, 0, Length(FNewVehicles));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetVehicleUpdates: TVehicleUpdateArray;
begin
  if Assigned(FVehicleUpdates) then begin
    result := Copy(FVehicleUpdates, 0, Length(FVehicleUpdates));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetTerrainByCellXY: TTerrainTypeArray2D;
var
  i: LongInt;

begin
  if Assigned(FTerrainByCellXY) then begin
    SetLength(result, Length(FTerrainByCellXY));

    for i := High(FTerrainByCellXY) downto 0 do begin
      if Assigned(FTerrainByCellXY[i]) then begin
        result[i] := Copy(FTerrainByCellXY[i], 0, Length(FTerrainByCellXY[i]));
      end else begin
        result[i] := nil;
      end;
    end;
  end else begin
    result := nil;
  end;
end;

function TWorld.GetWeatherByCellXY: TWeatherTypeArray2D;
var
  i: LongInt;

begin
  if Assigned(FWeatherByCellXY) then begin
    SetLength(result, Length(FWeatherByCellXY));

    for i := High(FWeatherByCellXY) downto 0 do begin
      if Assigned(FWeatherByCellXY[i]) then begin
        result[i] := Copy(FWeatherByCellXY[i], 0, Length(FWeatherByCellXY[i]));
      end else begin
        result[i] := nil;
      end;
    end;
  end else begin
    result := nil;
  end;
end;

function TWorld.GetFacilities: TFacilityArray;
begin
  if Assigned(FFacilities) then begin
    result := Copy(FFacilities, 0, Length(FFacilities));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetMyPlayer: TPlayer;
var
  playerIndex: LongInt;

begin
  for playerIndex := High(FPlayers) downto 0 do begin
    if FPlayers[playerIndex].GetMe then begin
      result := FPlayers[playerIndex];
      exit;
    end;
  end;

  result := nil;
end;

function TWorld.GetOpponentPlayer: TPlayer;
var
  playerIndex: LongInt;

begin
  for playerIndex := High(FPlayers) downto 0 do begin
    if not FPlayers[playerIndex].GetMe then begin
      result := FPlayers[playerIndex];
      exit;
    end;
  end;

  result := nil;
end;

destructor TWorld.Destroy;
var
  i: LongInt;

begin
  if Assigned(FPlayers) then begin
    for i := High(FPlayers) downto 0 do begin
      if Assigned(FPlayers[i]) then begin
        FPlayers[i].Free;
      end;
    end;
  end;

  if Assigned(FNewVehicles) then begin
    for i := High(FNewVehicles) downto 0 do begin
      if Assigned(FNewVehicles[i]) then begin
        FNewVehicles[i].Free;
      end;
    end;
  end;

  if Assigned(FVehicleUpdates) then begin
    for i := High(FVehicleUpdates) downto 0 do begin
      if Assigned(FVehicleUpdates[i]) then begin
        FVehicleUpdates[i].Free;
      end;
    end;
  end;

  if Assigned(FFacilities) then begin
    for i := High(FFacilities) downto 0 do begin
      if Assigned(FFacilities[i]) then begin
        FFacilities[i].Free;
      end;
    end;
  end;

  inherited;
end;

end.
