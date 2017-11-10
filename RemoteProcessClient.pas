unit RemoteProcessClient;

interface

uses
  SysUtils, SimpleSocket, TypeControl, FacilityControl, FacilityTypeControl, GameControl, MoveControl,
  PlayerContextControl, PlayerControl, TerrainTypeControl, UnitControl, VehicleControl, VehicleTypeControl,
  VehicleUpdateControl, WeatherTypeControl, WorldControl;

const
  UNKNOWN_MESSAGE     : LongInt = 0;
  GAME_OVER           : LongInt = 1;
  AUTHENTICATION_TOKEN: LongInt = 2;
  TEAM_SIZE           : LongInt = 3;
  PROTOCOL_VERSION    : LongInt = 4;
  GAME_CONTEXT        : LongInt = 5;
  PLAYER_CONTEXT      : LongInt = 6;
  MOVE_MESSAGE        : LongInt = 7;

  LITTLE_ENDIAN_BYTE_ORDER = true;
  INTEGER_SIZE_BYTES = sizeof(LongInt);
  LONG_SIZE_BYTES = sizeof(Int64);

type
  TMessageType = LongInt;

  TRemoteProcessClient = class
  private
    FSocket: ClientSocket;

    FPreviousPlayers: TPlayerArray;
    FPreviousFacilities: TFacilityArray;
    FTerrainByCellXY: TTerrainTypeArray2D;
    FWeatherByCellXY: TWeatherTypeArray2D;

    FPreviousPlayerById: TPlayerArray;
    FPreviousFacilityById: TFacilityArray;

    {$HINTS OFF}
    function ReadFacility: TFacility;
    procedure WriteFacility(facility: TFacility);
    function ReadFacilities: TFacilityArray;
    procedure WriteFacilities(facilities: TFacilityArray);
    function ReadGame: TGame;
    procedure WriteGame(game: TGame);
    function ReadGames: TGameArray;
    procedure WriteGames(games: TGameArray);
    procedure WriteMove(move: TMove);
    procedure WriteMoves(moves: TMoveArray);
    function ReadPlayer: TPlayer;
    procedure WritePlayer(player: TPlayer);
    function ReadPlayers: TPlayerArray;
    procedure WritePlayers(players: TPlayerArray);
    function ReadPlayerContext: TPlayerContext;
    procedure WritePlayerContext(playerContext: TPlayerContext);
    function ReadPlayerContexts: TPlayerContextArray;
    procedure WritePlayerContexts(playerContexts: TPlayerContextArray);
    function ReadVehicle: TVehicle;
    procedure WriteVehicle(vehicle: TVehicle);
    function ReadVehicles: TVehicleArray;
    procedure WriteVehicles(vehicles: TVehicleArray);
    function ReadVehicleUpdate: TVehicleUpdate;
    procedure WriteVehicleUpdate(vehicleUpdate: TVehicleUpdate);
    function ReadVehicleUpdates: TVehicleUpdateArray;
    procedure WriteVehicleUpdates(vehicleUpdates: TVehicleUpdateArray);
    function ReadWorld: TWorld;
    procedure WriteWorld(world: TWorld);
    function ReadWorlds: TWorldArray;
    procedure WriteWorlds(worlds: TWorldArray);
    {$HINTS ON}

    procedure EnsureMessageType(actualType: LongInt; expectedType: LongInt);

    {$HINTS OFF}
    function ReadByteArray(nullable: Boolean): TByteArray;
    procedure WriteByteArray(value: TByteArray);

    function ReadEnum: LongInt;
    function ReadEnumArray: TLongIntArray;
    function ReadEnumArray2D: TLongIntArray2D;
    procedure WriteEnum(value: LongInt);
    procedure WriteEnumArray(value: TLongIntArray);
    procedure WriteEnumArray2D(value: TLongIntArray2D);

    function ReadString: String;
    procedure WriteString(value: String);

    function ReadInt: LongInt;
    function ReadIntArray: TLongIntArray;
    function ReadIntArray2D: TLongIntArray2D;
    procedure WriteInt(value: LongInt);
    procedure WriteIntArray(value: TLongIntArray);
    procedure WriteIntArray2D(value: TLongIntArray2D);

    function ReadByte(): Byte;
    procedure WriteByte(byte: Byte);

    function ReadBytes(byteCount: LongInt): TByteArray;
    procedure WriteBytes(bytes: TByteArray);

    function ReadBoolean: Boolean;
    procedure WriteBoolean(value: Boolean);

    function ReadDouble: Double;
    procedure WriteDouble(value: Double);

    function ReadLong: Int64;
    procedure WriteLong(value: Int64);
    {$HINTS ON}

    function IsLittleEndianMachine: Boolean;

    procedure Reverse(var bytes: TByteArray);

  public
    constructor Create(host: String; port: LongInt);

    procedure WriteTokenMessage(token: String);
    procedure WriteProtocolVersionMessage;
    function ReadTeamSizeMessage: LongInt;
    function ReadGameContextMessage: TGame;
    function ReadPlayerContextMessage: TPlayerContext;
    procedure WriteMoveMessage(move: TMove);

    destructor Destroy; override;

end;

implementation

constructor TRemoteProcessClient.Create(host: String; port: LongInt);
begin
  FSocket := ClientSocket.Create(host, port);
  FPreviousPlayers := nil;
  FPreviousFacilities := nil;
  FTerrainByCellXY := nil;
  FWeatherByCellXY := nil;
  SetLength(FPreviousPlayerById, 100000);
  SetLength(FPreviousFacilityById, 100000);
end;

procedure TRemoteProcessClient.EnsureMessageType(actualType: LongInt; expectedType: LongInt);
begin
  if actualType <> expectedType then begin
    HALT(10001);
  end;
end;

procedure TRemoteProcessClient.WriteTokenMessage(token: String);
begin
  WriteEnum(AUTHENTICATION_TOKEN);
  WriteString(token);
end;

procedure TRemoteProcessClient.WriteProtocolVersionMessage;
begin
  WriteEnum(PROTOCOL_VERSION);
  WriteInt(2);
end;

function TRemoteProcessClient.ReadTeamSizeMessage: LongInt;
begin
  EnsureMessageType(ReadEnum, TEAM_SIZE);
  result := ReadInt;
end;

function TRemoteProcessClient.ReadGameContextMessage: TGame;
begin
  EnsureMessageType(ReadEnum, GAME_CONTEXT);
  result := ReadGame;
end;

function TRemoteProcessClient.ReadPlayerContextMessage: TPlayerContext;
var
  messageType: TMessageType;

begin
  messageType := ReadEnum;
  if messageType = GAME_OVER then begin
    result := nil;
    exit;
  end;

  EnsureMessageType(messageType, PLAYER_CONTEXT);
  result := ReadPlayerContext;
end;

procedure TRemoteProcessClient.WriteMoveMessage(move: TMove);
begin
  WriteEnum(MOVE_MESSAGE);
  WriteMove(move);
end;

function TRemoteProcessClient.ReadFacility: TFacility;
var
  flag: Byte;
  id: Int64;
  facilityType: TFacilityType;
  ownerPlayerId: Int64;
  left: Double;
  top: Double;
  capturePoints: Double;
  vehicleType: TVehicleType;
  productionProgress: LongInt;

begin
  flag := ReadByte;

  if flag = 0 then begin
    result := nil;
    exit;
  end;

  if flag = 127 then begin
    result := TFacility.Create(FPreviousFacilityById[ReadLong]);
    exit;
  end;

  id := ReadLong;
  facilityType := ReadEnum;
  ownerPlayerId := ReadLong;
  left := ReadDouble;
  top := ReadDouble;
  capturePoints := ReadDouble;
  vehicleType := ReadEnum;
  productionProgress := ReadInt;

  if Assigned(FPreviousFacilityById[id]) then begin
    FPreviousFacilityById[id].Free;
  end;

  FPreviousFacilityById[id] := TFacility.Create(id, facilityType, ownerPlayerId, left, top, capturePoints, vehicleType,
    productionProgress);

  result := TFacility.Create(FPreviousFacilityById[id]);
end;

procedure TRemoteProcessClient.WriteFacility(facility: TFacility);
begin
  if facility = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(facility.GetId);
  WriteEnum(facility.GetType);
  WriteLong(facility.GetOwnerPlayerId);
  WriteDouble(facility.GetLeft);
  WriteDouble(facility.GetTop);
  WriteDouble(facility.GetCapturePoints);
  WriteEnum(facility.GetVehicleType);
  WriteInt(facility.GetProductionProgress);
end;

function TRemoteProcessClient.ReadFacilities: TFacilityArray;
var
  facilityIndex: LongInt;
  facilityCount: LongInt;

begin
  facilityCount := ReadInt;
  if facilityCount < 0 then begin
    SetLength(result, Length(FPreviousFacilities));
    for facilityIndex := High(FPreviousFacilities) downto 0 do begin
      result[facilityIndex] := TFacility.Create(FPreviousFacilities[facilityIndex]);
    end;
    exit;
  end;

  if Assigned(FPreviousFacilities) then begin
    for facilityIndex := High(FPreviousFacilities) downto 0 do begin
      if Assigned(FPreviousFacilities[facilityIndex]) then begin
        FPreviousFacilities[facilityIndex].Free;
      end;
    end;
  end;

  SetLength(FPreviousFacilities, facilityCount);
  SetLength(result, facilityCount);

  for facilityIndex := 0 to facilityCount - 1 do begin
    FPreviousFacilities[facilityIndex] := ReadFacility;
    result[facilityIndex] := TFacility.Create(FPreviousFacilities[facilityIndex]);
  end;
end;

procedure TRemoteProcessClient.WriteFacilities(facilities: TFacilityArray);
var
  facilityIndex: LongInt;
  facilityCount: LongInt;

begin
  if facilities = nil then begin
    WriteInt(-1);
    exit;
  end;

  facilityCount := Length(facilities);
  WriteInt(facilityCount);

  for facilityIndex := 0 to facilityCount - 1 do begin
    WriteFacility(facilities[facilityIndex]);
  end;
end;

function TRemoteProcessClient.ReadGame: TGame;
var
  randomSeed: Int64;
  tickCount: LongInt;
  worldWidth: Double;
  worldHeight: Double;
  fogOfWarEnabled: Boolean;
  victoryScore: LongInt;
  facilityCaptureScore: LongInt;
  vehicleEliminationScore: LongInt;
  actionDetectionInterval: LongInt;
  baseActionCount: LongInt;
  additionalActionCountPerControlCenter: LongInt;
  maxUnitGroup: LongInt;
  terrainWeatherMapColumnCount: LongInt;
  terrainWeatherMapRowCount: LongInt;
  plainTerrainVisionFactor: Double;
  plainTerrainStealthFactor: Double;
  plainTerrainSpeedFactor: Double;
  swampTerrainVisionFactor: Double;
  swampTerrainStealthFactor: Double;
  swampTerrainSpeedFactor: Double;
  forestTerrainVisionFactor: Double;
  forestTerrainStealthFactor: Double;
  forestTerrainSpeedFactor: Double;
  clearWeatherVisionFactor: Double;
  clearWeatherStealthFactor: Double;
  clearWeatherSpeedFactor: Double;
  cloudWeatherVisionFactor: Double;
  cloudWeatherStealthFactor: Double;
  cloudWeatherSpeedFactor: Double;
  rainWeatherVisionFactor: Double;
  rainWeatherStealthFactor: Double;
  rainWeatherSpeedFactor: Double;
  vehicleRadius: Double;
  tankDurability: LongInt;
  tankSpeed: Double;
  tankVisionRange: Double;
  tankGroundAttackRange: Double;
  tankAerialAttackRange: Double;
  tankGroundDamage: LongInt;
  tankAerialDamage: LongInt;
  tankGroundDefence: LongInt;
  tankAerialDefence: LongInt;
  tankAttackCooldownTicks: LongInt;
  tankProductionCost: LongInt;
  ifvDurability: LongInt;
  ifvSpeed: Double;
  ifvVisionRange: Double;
  ifvGroundAttackRange: Double;
  ifvAerialAttackRange: Double;
  ifvGroundDamage: LongInt;
  ifvAerialDamage: LongInt;
  ifvGroundDefence: LongInt;
  ifvAerialDefence: LongInt;
  ifvAttackCooldownTicks: LongInt;
  ifvProductionCost: LongInt;
  arrvDurability: LongInt;
  arrvSpeed: Double;
  arrvVisionRange: Double;
  arrvGroundDefence: LongInt;
  arrvAerialDefence: LongInt;
  arrvProductionCost: LongInt;
  arrvRepairRange: Double;
  arrvRepairSpeed: Double;
  helicopterDurability: LongInt;
  helicopterSpeed: Double;
  helicopterVisionRange: Double;
  helicopterGroundAttackRange: Double;
  helicopterAerialAttackRange: Double;
  helicopterGroundDamage: LongInt;
  helicopterAerialDamage: LongInt;
  helicopterGroundDefence: LongInt;
  helicopterAerialDefence: LongInt;
  helicopterAttackCooldownTicks: LongInt;
  helicopterProductionCost: LongInt;
  fighterDurability: LongInt;
  fighterSpeed: Double;
  fighterVisionRange: Double;
  fighterGroundAttackRange: Double;
  fighterAerialAttackRange: Double;
  fighterGroundDamage: LongInt;
  fighterAerialDamage: LongInt;
  fighterGroundDefence: LongInt;
  fighterAerialDefence: LongInt;
  fighterAttackCooldownTicks: LongInt;
  fighterProductionCost: LongInt;
  maxFacilityCapturePoints: Double;
  facilityCapturePointsPerVehiclePerTick: Double;
  facilityWidth: Double;
  facilityHeight: Double;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  randomSeed := ReadLong;
  tickCount := ReadInt;
  worldWidth := ReadDouble;
  worldHeight := ReadDouble;
  fogOfWarEnabled := ReadBoolean;
  victoryScore := ReadInt;
  facilityCaptureScore := ReadInt;
  vehicleEliminationScore := ReadInt;
  actionDetectionInterval := ReadInt;
  baseActionCount := ReadInt;
  additionalActionCountPerControlCenter := ReadInt;
  maxUnitGroup := ReadInt;
  terrainWeatherMapColumnCount := ReadInt;
  terrainWeatherMapRowCount := ReadInt;
  plainTerrainVisionFactor := ReadDouble;
  plainTerrainStealthFactor := ReadDouble;
  plainTerrainSpeedFactor := ReadDouble;
  swampTerrainVisionFactor := ReadDouble;
  swampTerrainStealthFactor := ReadDouble;
  swampTerrainSpeedFactor := ReadDouble;
  forestTerrainVisionFactor := ReadDouble;
  forestTerrainStealthFactor := ReadDouble;
  forestTerrainSpeedFactor := ReadDouble;
  clearWeatherVisionFactor := ReadDouble;
  clearWeatherStealthFactor := ReadDouble;
  clearWeatherSpeedFactor := ReadDouble;
  cloudWeatherVisionFactor := ReadDouble;
  cloudWeatherStealthFactor := ReadDouble;
  cloudWeatherSpeedFactor := ReadDouble;
  rainWeatherVisionFactor := ReadDouble;
  rainWeatherStealthFactor := ReadDouble;
  rainWeatherSpeedFactor := ReadDouble;
  vehicleRadius := ReadDouble;
  tankDurability := ReadInt;
  tankSpeed := ReadDouble;
  tankVisionRange := ReadDouble;
  tankGroundAttackRange := ReadDouble;
  tankAerialAttackRange := ReadDouble;
  tankGroundDamage := ReadInt;
  tankAerialDamage := ReadInt;
  tankGroundDefence := ReadInt;
  tankAerialDefence := ReadInt;
  tankAttackCooldownTicks := ReadInt;
  tankProductionCost := ReadInt;
  ifvDurability := ReadInt;
  ifvSpeed := ReadDouble;
  ifvVisionRange := ReadDouble;
  ifvGroundAttackRange := ReadDouble;
  ifvAerialAttackRange := ReadDouble;
  ifvGroundDamage := ReadInt;
  ifvAerialDamage := ReadInt;
  ifvGroundDefence := ReadInt;
  ifvAerialDefence := ReadInt;
  ifvAttackCooldownTicks := ReadInt;
  ifvProductionCost := ReadInt;
  arrvDurability := ReadInt;
  arrvSpeed := ReadDouble;
  arrvVisionRange := ReadDouble;
  arrvGroundDefence := ReadInt;
  arrvAerialDefence := ReadInt;
  arrvProductionCost := ReadInt;
  arrvRepairRange := ReadDouble;
  arrvRepairSpeed := ReadDouble;
  helicopterDurability := ReadInt;
  helicopterSpeed := ReadDouble;
  helicopterVisionRange := ReadDouble;
  helicopterGroundAttackRange := ReadDouble;
  helicopterAerialAttackRange := ReadDouble;
  helicopterGroundDamage := ReadInt;
  helicopterAerialDamage := ReadInt;
  helicopterGroundDefence := ReadInt;
  helicopterAerialDefence := ReadInt;
  helicopterAttackCooldownTicks := ReadInt;
  helicopterProductionCost := ReadInt;
  fighterDurability := ReadInt;
  fighterSpeed := ReadDouble;
  fighterVisionRange := ReadDouble;
  fighterGroundAttackRange := ReadDouble;
  fighterAerialAttackRange := ReadDouble;
  fighterGroundDamage := ReadInt;
  fighterAerialDamage := ReadInt;
  fighterGroundDefence := ReadInt;
  fighterAerialDefence := ReadInt;
  fighterAttackCooldownTicks := ReadInt;
  fighterProductionCost := ReadInt;
  maxFacilityCapturePoints := ReadDouble;
  facilityCapturePointsPerVehiclePerTick := ReadDouble;
  facilityWidth := ReadDouble;
  facilityHeight := ReadDouble;

  result := TGame.Create(randomSeed, tickCount, worldWidth, worldHeight, fogOfWarEnabled, victoryScore,
    facilityCaptureScore, vehicleEliminationScore, actionDetectionInterval, baseActionCount,
    additionalActionCountPerControlCenter, maxUnitGroup, terrainWeatherMapColumnCount, terrainWeatherMapRowCount,
    plainTerrainVisionFactor, plainTerrainStealthFactor, plainTerrainSpeedFactor, swampTerrainVisionFactor,
    swampTerrainStealthFactor, swampTerrainSpeedFactor, forestTerrainVisionFactor, forestTerrainStealthFactor,
    forestTerrainSpeedFactor, clearWeatherVisionFactor, clearWeatherStealthFactor, clearWeatherSpeedFactor,
    cloudWeatherVisionFactor, cloudWeatherStealthFactor, cloudWeatherSpeedFactor, rainWeatherVisionFactor,
    rainWeatherStealthFactor, rainWeatherSpeedFactor, vehicleRadius, tankDurability, tankSpeed, tankVisionRange,
    tankGroundAttackRange, tankAerialAttackRange, tankGroundDamage, tankAerialDamage, tankGroundDefence,
    tankAerialDefence, tankAttackCooldownTicks, tankProductionCost, ifvDurability, ifvSpeed, ifvVisionRange,
    ifvGroundAttackRange, ifvAerialAttackRange, ifvGroundDamage, ifvAerialDamage, ifvGroundDefence, ifvAerialDefence,
    ifvAttackCooldownTicks, ifvProductionCost, arrvDurability, arrvSpeed, arrvVisionRange, arrvGroundDefence,
    arrvAerialDefence, arrvProductionCost, arrvRepairRange, arrvRepairSpeed, helicopterDurability, helicopterSpeed,
    helicopterVisionRange, helicopterGroundAttackRange, helicopterAerialAttackRange, helicopterGroundDamage,
    helicopterAerialDamage, helicopterGroundDefence, helicopterAerialDefence, helicopterAttackCooldownTicks,
    helicopterProductionCost, fighterDurability, fighterSpeed, fighterVisionRange, fighterGroundAttackRange,
    fighterAerialAttackRange, fighterGroundDamage, fighterAerialDamage, fighterGroundDefence, fighterAerialDefence,
    fighterAttackCooldownTicks, fighterProductionCost, maxFacilityCapturePoints, facilityCapturePointsPerVehiclePerTick,
    facilityWidth, facilityHeight);
end;

procedure TRemoteProcessClient.WriteGame(game: TGame);
begin
  if game = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(game.GetRandomSeed);
  WriteInt(game.GetTickCount);
  WriteDouble(game.GetWorldWidth);
  WriteDouble(game.GetWorldHeight);
  WriteBoolean(game.GetFogOfWarEnabled);
  WriteInt(game.GetVictoryScore);
  WriteInt(game.GetFacilityCaptureScore);
  WriteInt(game.GetVehicleEliminationScore);
  WriteInt(game.GetActionDetectionInterval);
  WriteInt(game.GetBaseActionCount);
  WriteInt(game.GetAdditionalActionCountPerControlCenter);
  WriteInt(game.GetMaxUnitGroup);
  WriteInt(game.GetTerrainWeatherMapColumnCount);
  WriteInt(game.GetTerrainWeatherMapRowCount);
  WriteDouble(game.GetPlainTerrainVisionFactor);
  WriteDouble(game.GetPlainTerrainStealthFactor);
  WriteDouble(game.GetPlainTerrainSpeedFactor);
  WriteDouble(game.GetSwampTerrainVisionFactor);
  WriteDouble(game.GetSwampTerrainStealthFactor);
  WriteDouble(game.GetSwampTerrainSpeedFactor);
  WriteDouble(game.GetForestTerrainVisionFactor);
  WriteDouble(game.GetForestTerrainStealthFactor);
  WriteDouble(game.GetForestTerrainSpeedFactor);
  WriteDouble(game.GetClearWeatherVisionFactor);
  WriteDouble(game.GetClearWeatherStealthFactor);
  WriteDouble(game.GetClearWeatherSpeedFactor);
  WriteDouble(game.GetCloudWeatherVisionFactor);
  WriteDouble(game.GetCloudWeatherStealthFactor);
  WriteDouble(game.GetCloudWeatherSpeedFactor);
  WriteDouble(game.GetRainWeatherVisionFactor);
  WriteDouble(game.GetRainWeatherStealthFactor);
  WriteDouble(game.GetRainWeatherSpeedFactor);
  WriteDouble(game.GetVehicleRadius);
  WriteInt(game.GetTankDurability);
  WriteDouble(game.GetTankSpeed);
  WriteDouble(game.GetTankVisionRange);
  WriteDouble(game.GetTankGroundAttackRange);
  WriteDouble(game.GetTankAerialAttackRange);
  WriteInt(game.GetTankGroundDamage);
  WriteInt(game.GetTankAerialDamage);
  WriteInt(game.GetTankGroundDefence);
  WriteInt(game.GetTankAerialDefence);
  WriteInt(game.GetTankAttackCooldownTicks);
  WriteInt(game.GetTankProductionCost);
  WriteInt(game.GetIfvDurability);
  WriteDouble(game.GetIfvSpeed);
  WriteDouble(game.GetIfvVisionRange);
  WriteDouble(game.GetIfvGroundAttackRange);
  WriteDouble(game.GetIfvAerialAttackRange);
  WriteInt(game.GetIfvGroundDamage);
  WriteInt(game.GetIfvAerialDamage);
  WriteInt(game.GetIfvGroundDefence);
  WriteInt(game.GetIfvAerialDefence);
  WriteInt(game.GetIfvAttackCooldownTicks);
  WriteInt(game.GetIfvProductionCost);
  WriteInt(game.GetArrvDurability);
  WriteDouble(game.GetArrvSpeed);
  WriteDouble(game.GetArrvVisionRange);
  WriteInt(game.GetArrvGroundDefence);
  WriteInt(game.GetArrvAerialDefence);
  WriteInt(game.GetArrvProductionCost);
  WriteDouble(game.GetArrvRepairRange);
  WriteDouble(game.GetArrvRepairSpeed);
  WriteInt(game.GetHelicopterDurability);
  WriteDouble(game.GetHelicopterSpeed);
  WriteDouble(game.GetHelicopterVisionRange);
  WriteDouble(game.GetHelicopterGroundAttackRange);
  WriteDouble(game.GetHelicopterAerialAttackRange);
  WriteInt(game.GetHelicopterGroundDamage);
  WriteInt(game.GetHelicopterAerialDamage);
  WriteInt(game.GetHelicopterGroundDefence);
  WriteInt(game.GetHelicopterAerialDefence);
  WriteInt(game.GetHelicopterAttackCooldownTicks);
  WriteInt(game.GetHelicopterProductionCost);
  WriteInt(game.GetFighterDurability);
  WriteDouble(game.GetFighterSpeed);
  WriteDouble(game.GetFighterVisionRange);
  WriteDouble(game.GetFighterGroundAttackRange);
  WriteDouble(game.GetFighterAerialAttackRange);
  WriteInt(game.GetFighterGroundDamage);
  WriteInt(game.GetFighterAerialDamage);
  WriteInt(game.GetFighterGroundDefence);
  WriteInt(game.GetFighterAerialDefence);
  WriteInt(game.GetFighterAttackCooldownTicks);
  WriteInt(game.GetFighterProductionCost);
  WriteDouble(game.GetMaxFacilityCapturePoints);
  WriteDouble(game.GetFacilityCapturePointsPerVehiclePerTick);
  WriteDouble(game.GetFacilityWidth);
  WriteDouble(game.GetFacilityHeight);
end;

function TRemoteProcessClient.ReadGames: TGameArray;
var
  gameIndex: LongInt;
  gameCount: LongInt;

begin
  gameCount := ReadInt;
  if gameCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, gameCount);

  for gameIndex := 0 to gameCount - 1 do begin
    result[gameIndex] := ReadGame;
  end;
end;

procedure TRemoteProcessClient.WriteGames(games: TGameArray);
var
  gameIndex: LongInt;
  gameCount: LongInt;

begin
  if games = nil then begin
    WriteInt(-1);
    exit;
  end;

  gameCount := Length(games);
  WriteInt(gameCount);

  for gameIndex := 0 to gameCount - 1 do begin
    WriteGame(games[gameIndex]);
  end;
end;

procedure TRemoteProcessClient.WriteMove(move: TMove);
begin
  if move = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteEnum(move.Action);
  WriteInt(move.Group);
  WriteDouble(move.Left);
  WriteDouble(move.Top);
  WriteDouble(move.Right);
  WriteDouble(move.Bottom);
  WriteDouble(move.X);
  WriteDouble(move.Y);
  WriteDouble(move.Angle);
  WriteDouble(move.Factor);
  WriteDouble(move.MaxSpeed);
  WriteDouble(move.MaxAngularSpeed);
  WriteEnum(move.VehicleType);
  WriteLong(move.FacilityId);
end;

procedure TRemoteProcessClient.WriteMoves(moves: TMoveArray);
var
  moveIndex: LongInt;
  moveCount: LongInt;

begin
  if moves = nil then begin
    WriteInt(-1);
    exit;
  end;

  moveCount := Length(moves);
  WriteInt(moveCount);

  for moveIndex := 0 to moveCount - 1 do begin
    WriteMove(moves[moveIndex]);
  end;
end;

function TRemoteProcessClient.ReadPlayer: TPlayer;
var
  flag: Byte;
  id: Int64;
  me: Boolean;
  strategyCrashed: Boolean;
  score: LongInt;
  remainingActionCooldownTicks: LongInt;

begin
  flag := ReadByte;

  if flag = 0 then begin
    result := nil;
    exit;
  end;

  if flag = 127 then begin
    result := TPlayer.Create(FPreviousPlayerById[ReadLong]);
    exit;
  end;

  id := ReadLong;
  me := ReadBoolean;
  strategyCrashed := ReadBoolean;
  score := ReadInt;
  remainingActionCooldownTicks := ReadInt;

  if Assigned(FPreviousPlayerById[id]) then begin
    FPreviousPlayerById[id].Free;
  end;

  FPreviousPlayerById[id] := TPlayer.Create(id, me, strategyCrashed, score, remainingActionCooldownTicks);

  result := TPlayer.Create(FPreviousPlayerById[id]);
end;

procedure TRemoteProcessClient.WritePlayer(player: TPlayer);
begin
  if player = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(player.GetId);
  WriteBoolean(player.GetMe);
  WriteBoolean(player.GetStrategyCrashed);
  WriteInt(player.GetScore);
  WriteInt(player.GetRemainingActionCooldownTicks);
end;

function TRemoteProcessClient.ReadPlayers: TPlayerArray;
var
  playerIndex: LongInt;
  playerCount: LongInt;

begin
  playerCount := ReadInt;
  if playerCount < 0 then begin
    SetLength(result, Length(FPreviousPlayers));
    for playerIndex := High(FPreviousPlayers) downto 0 do begin
      result[playerIndex] := TPlayer.Create(FPreviousPlayers[playerIndex]);
    end;
    exit;
  end;

  if Assigned(FPreviousPlayers) then begin
    for playerIndex := High(FPreviousPlayers) downto 0 do begin
      if Assigned(FPreviousPlayers[playerIndex]) then begin
        FPreviousPlayers[playerIndex].Free;
      end;
    end;
  end;

  SetLength(FPreviousPlayers, playerCount);
  SetLength(result, playerCount);

  for playerIndex := 0 to playerCount - 1 do begin
    FPreviousPlayers[playerIndex] := ReadPlayer;
    result[playerIndex] := TPlayer.Create(FPreviousPlayers[playerIndex]);
  end;
end;

procedure TRemoteProcessClient.WritePlayers(players: TPlayerArray);
var
  playerIndex: LongInt;
  playerCount: LongInt;

begin
  if players = nil then begin
    WriteInt(-1);
    exit;
  end;

  playerCount := Length(players);
  WriteInt(playerCount);

  for playerIndex := 0 to playerCount - 1 do begin
    WritePlayer(players[playerIndex]);
  end;
end;

function TRemoteProcessClient.ReadPlayerContext: TPlayerContext;
var
  player: TPlayer;
  world: TWorld;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  player := ReadPlayer;
  world := ReadWorld;

  result := TPlayerContext.Create(player, world);
end;

procedure TRemoteProcessClient.WritePlayerContext(playerContext: TPlayerContext);
begin
  if playerContext = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WritePlayer(playerContext.GetPlayer);
  WriteWorld(playerContext.GetWorld);
end;

function TRemoteProcessClient.ReadPlayerContexts: TPlayerContextArray;
var
  playerContextIndex: LongInt;
  playerContextCount: LongInt;

begin
  playerContextCount := ReadInt;
  if playerContextCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, playerContextCount);

  for playerContextIndex := 0 to playerContextCount - 1 do begin
    result[playerContextIndex] := ReadPlayerContext;
  end;
end;

procedure TRemoteProcessClient.WritePlayerContexts(playerContexts: TPlayerContextArray);
var
  playerContextIndex: LongInt;
  playerContextCount: LongInt;

begin
  if playerContexts = nil then begin
    WriteInt(-1);
    exit;
  end;

  playerContextCount := Length(playerContexts);
  WriteInt(playerContextCount);

  for playerContextIndex := 0 to playerContextCount - 1 do begin
    WritePlayerContext(playerContexts[playerContextIndex]);
  end;
end;

function TRemoteProcessClient.ReadVehicle: TVehicle;
var
  id: Int64;
  x: Double;
  y: Double;
  radius: Double;
  playerId: Int64;
  durability: LongInt;
  maxDurability: LongInt;
  maxSpeed: Double;
  visionRange: Double;
  squaredVisionRange: Double;
  groundAttackRange: Double;
  squaredGroundAttackRange: Double;
  aerialAttackRange: Double;
  squaredAerialAttackRange: Double;
  groundDamage: LongInt;
  aerialDamage: LongInt;
  groundDefence: LongInt;
  aerialDefence: LongInt;
  attackCooldownTicks: LongInt;
  remainingAttackCooldownTicks: LongInt;
  vehicleType: TVehicleType;
  aerial: Boolean;
  selected: Boolean;
  groups: TLongIntArray;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  radius := ReadDouble;
  playerId := ReadLong;
  durability := ReadInt;
  maxDurability := ReadInt;
  maxSpeed := ReadDouble;
  visionRange := ReadDouble;
  squaredVisionRange := ReadDouble;
  groundAttackRange := ReadDouble;
  squaredGroundAttackRange := ReadDouble;
  aerialAttackRange := ReadDouble;
  squaredAerialAttackRange := ReadDouble;
  groundDamage := ReadInt;
  aerialDamage := ReadInt;
  groundDefence := ReadInt;
  aerialDefence := ReadInt;
  attackCooldownTicks := ReadInt;
  remainingAttackCooldownTicks := ReadInt;
  vehicleType := ReadEnum;
  aerial := ReadBoolean;
  selected := ReadBoolean;
  groups := ReadIntArray;

  result := TVehicle.Create(id, x, y, radius, playerId, durability, maxDurability, maxSpeed, visionRange,
    squaredVisionRange, groundAttackRange, squaredGroundAttackRange, aerialAttackRange, squaredAerialAttackRange,
    groundDamage, aerialDamage, groundDefence, aerialDefence, attackCooldownTicks, remainingAttackCooldownTicks,
    vehicleType, aerial, selected, groups);
end;

procedure TRemoteProcessClient.WriteVehicle(vehicle: TVehicle);
begin
  if vehicle = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(vehicle.GetId);
  WriteDouble(vehicle.GetX);
  WriteDouble(vehicle.GetY);
  WriteDouble(vehicle.GetRadius);
  WriteLong(vehicle.GetPlayerId);
  WriteInt(vehicle.GetDurability);
  WriteInt(vehicle.GetMaxDurability);
  WriteDouble(vehicle.GetMaxSpeed);
  WriteDouble(vehicle.GetVisionRange);
  WriteDouble(vehicle.GetSquaredVisionRange);
  WriteDouble(vehicle.GetGroundAttackRange);
  WriteDouble(vehicle.GetSquaredGroundAttackRange);
  WriteDouble(vehicle.GetAerialAttackRange);
  WriteDouble(vehicle.GetSquaredAerialAttackRange);
  WriteInt(vehicle.GetGroundDamage);
  WriteInt(vehicle.GetAerialDamage);
  WriteInt(vehicle.GetGroundDefence);
  WriteInt(vehicle.GetAerialDefence);
  WriteInt(vehicle.GetAttackCooldownTicks);
  WriteInt(vehicle.GetRemainingAttackCooldownTicks);
  WriteEnum(vehicle.GetType);
  WriteBoolean(vehicle.GetAerial);
  WriteBoolean(vehicle.GetSelected);
  WriteIntArray(vehicle.GetGroups);
end;

function TRemoteProcessClient.ReadVehicles: TVehicleArray;
var
  vehicleIndex: LongInt;
  vehicleCount: LongInt;

begin
  vehicleCount := ReadInt;
  if vehicleCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, vehicleCount);

  for vehicleIndex := 0 to vehicleCount - 1 do begin
    result[vehicleIndex] := ReadVehicle;
  end;
end;

procedure TRemoteProcessClient.WriteVehicles(vehicles: TVehicleArray);
var
  vehicleIndex: LongInt;
  vehicleCount: LongInt;

begin
  if vehicles = nil then begin
    WriteInt(-1);
    exit;
  end;

  vehicleCount := Length(vehicles);
  WriteInt(vehicleCount);

  for vehicleIndex := 0 to vehicleCount - 1 do begin
    WriteVehicle(vehicles[vehicleIndex]);
  end;
end;

function TRemoteProcessClient.ReadVehicleUpdate: TVehicleUpdate;
var
  id: Int64;
  x: Double;
  y: Double;
  durability: LongInt;
  remainingAttackCooldownTicks: LongInt;
  selected: Boolean;
  groups: TLongIntArray;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  id := ReadLong;
  x := ReadDouble;
  y := ReadDouble;
  durability := ReadInt;
  remainingAttackCooldownTicks := ReadInt;
  selected := ReadBoolean;
  groups := ReadIntArray;

  result := TVehicleUpdate.Create(id, x, y, durability, remainingAttackCooldownTicks, selected, groups);
end;

procedure TRemoteProcessClient.WriteVehicleUpdate(vehicleUpdate: TVehicleUpdate);
begin
  if vehicleUpdate = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteLong(vehicleUpdate.GetId);
  WriteDouble(vehicleUpdate.GetX);
  WriteDouble(vehicleUpdate.GetY);
  WriteInt(vehicleUpdate.GetDurability);
  WriteInt(vehicleUpdate.GetRemainingAttackCooldownTicks);
  WriteBoolean(vehicleUpdate.GetSelected);
  WriteIntArray(vehicleUpdate.GetGroups);
end;

function TRemoteProcessClient.ReadVehicleUpdates: TVehicleUpdateArray;
var
  vehicleUpdateIndex: LongInt;
  vehicleUpdateCount: LongInt;

begin
  vehicleUpdateCount := ReadInt;
  if vehicleUpdateCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, vehicleUpdateCount);

  for vehicleUpdateIndex := 0 to vehicleUpdateCount - 1 do begin
    result[vehicleUpdateIndex] := ReadVehicleUpdate;
  end;
end;

procedure TRemoteProcessClient.WriteVehicleUpdates(vehicleUpdates: TVehicleUpdateArray);
var
  vehicleUpdateIndex: LongInt;
  vehicleUpdateCount: LongInt;

begin
  if vehicleUpdates = nil then begin
    WriteInt(-1);
    exit;
  end;

  vehicleUpdateCount := Length(vehicleUpdates);
  WriteInt(vehicleUpdateCount);

  for vehicleUpdateIndex := 0 to vehicleUpdateCount - 1 do begin
    WriteVehicleUpdate(vehicleUpdates[vehicleUpdateIndex]);
  end;
end;

function TRemoteProcessClient.ReadWorld: TWorld;
var
  tickIndex: LongInt;
  tickCount: LongInt;
  width: Double;
  height: Double;
  players: TPlayerArray;
  newVehicles: TVehicleArray;
  vehicleUpdates: TVehicleUpdateArray;
  facilities: TFacilityArray;

begin
  if not ReadBoolean then begin
    result := nil;
    exit;
  end;

  tickIndex := ReadInt;
  tickCount := ReadInt;
  width := ReadDouble;
  height := ReadDouble;
  players := ReadPlayers;
  newVehicles := ReadVehicles;
  vehicleUpdates := ReadVehicleUpdates;

  if not Assigned(FTerrainByCellXY) then begin
    FTerrainByCellXY := ReadEnumArray2D;
  end;

  if not Assigned(FWeatherByCellXY) then begin
    FWeatherByCellXY := ReadEnumArray2D;
  end;

  facilities := ReadFacilities;

  result := TWorld.Create(tickIndex, tickCount, width, height, players, newVehicles, vehicleUpdates, FTerrainByCellXY,
    FWeatherByCellXY, facilities);
end;

procedure TRemoteProcessClient.WriteWorld(world: TWorld);
begin
  if world = nil then begin
    WriteBoolean(false);
    exit;
  end;

  WriteBoolean(true);

  WriteInt(world.GetTickIndex);
  WriteInt(world.GetTickCount);
  WriteDouble(world.GetWidth);
  WriteDouble(world.GetHeight);
  WritePlayers(world.GetPlayers);
  WriteVehicles(world.GetNewVehicles);
  WriteVehicleUpdates(world.GetVehicleUpdates);
  WriteEnumArray2D(world.GetTerrainByCellXY);
  WriteEnumArray2D(world.GetWeatherByCellXY);
  WriteFacilities(world.GetFacilities);
end;

function TRemoteProcessClient.ReadWorlds: TWorldArray;
var
  worldIndex: LongInt;
  worldCount: LongInt;

begin
  worldCount := ReadInt;
  if worldCount < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, worldCount);

  for worldIndex := 0 to worldCount - 1 do begin
    result[worldIndex] := ReadWorld;
  end;
end;

procedure TRemoteProcessClient.WriteWorlds(worlds: TWorldArray);
var
  worldIndex: LongInt;
  worldCount: LongInt;

begin
  if worlds = nil then begin
    WriteInt(-1);
    exit;
  end;

  worldCount := Length(worlds);
  WriteInt(worldCount);

  for worldIndex := 0 to worldCount - 1 do begin
    WriteWorld(worlds[worldIndex]);
  end;
end;

function TRemoteProcessClient.ReadByteArray(nullable: Boolean): TByteArray;
var
  len: LongInt;

begin
  len := ReadInt;

  if nullable then begin
    if len < 0 then begin
      result := nil;
      exit;
    end;
  end else begin
    if len <= 0 then begin
      SetLength(result, 0);
      exit;
    end;
  end;

  result := ReadBytes(len);
end;

procedure TRemoteProcessClient.WriteByteArray(value: TByteArray);
begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  WriteInt(Length(value));
  WriteBytes(value);
end;

procedure TRemoteProcessClient.WriteEnum(value: LongInt);
var
  bytes: TByteArray;

begin
  SetLength(bytes, 1);
  bytes[0] := value;
  WriteBytes(bytes);
  Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteEnumArray(value: TLongIntArray);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteEnum(value[i]);
  end;
end;

procedure TRemoteProcessClient.WriteEnumArray2D(value: TLongIntArray2D);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteEnumArray(value[i]);
  end;
end;

function TRemoteProcessClient.ReadEnum: TMessageType;
var
  bytes: TByteArray;

begin
  bytes := ReadBytes(1);
  result := bytes[0];
  Finalize(bytes);
end;

function TRemoteProcessClient.ReadEnumArray: TLongIntArray;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadEnum;
  end;
end;

function TRemoteProcessClient.ReadEnumArray2D: TLongIntArray2D;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadEnumArray;
  end;
end;

function TRemoteProcessClient.ReadByte(): Byte;
var
  bytes: TByteArray;

begin
  SetLength(bytes, 1);
  FSocket.StrictReceive(bytes, 1);
  result := bytes[0];
  Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteByte(byte: Byte);
var
  bytes: TByteArray;

begin
  SetLength(bytes, 1);
  bytes[0] := byte;
  FSocket.StrictSend(bytes, 1);
  Finalize(bytes);
end;

function TRemoteProcessClient.ReadBytes(byteCount: LongInt): TByteArray;
var
  bytes: TByteArray;

begin
  SetLength(bytes, byteCount);
  FSocket.StrictReceive(bytes, byteCount);
  result := bytes;
end;

procedure TRemoteProcessClient.WriteBytes(bytes: TByteArray);
begin
  FSocket.StrictSend(bytes, Length(bytes));
end;

procedure TRemoteProcessClient.WriteString(value: String);
var
  len, i: LongInt;
  bytes: TByteArray;
  AnsiValue: AnsiString;

begin
  AnsiValue := AnsiString(value);

  len := Length(AnsiValue);
  SetLength(bytes, len);
  for i := 1 to len do begin
    bytes[i - 1] := Ord(AnsiValue[i]);
  end;

  WriteInt(len);
  WriteBytes(bytes);
  Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteBoolean(value: Boolean);
begin
  WriteByte(Ord(value));
end;

function TRemoteProcessClient.ReadBoolean: Boolean;
begin
  result := (ReadByte() <> 0);
end;

function TRemoteProcessClient.ReadString: String;
var
  len, i: LongInt;
  bytes: TByteArray;
  res: AnsiString;

begin
  len := ReadInt;
  if len = -1 then begin
    HALT(10014);
  end;

  res := '';
  bytes := ReadBytes(len);
  for i := 0 to len - 1 do begin
    res := res + AnsiChar(bytes[i]);
  end;
    
  Finalize(bytes);
  result := string(res);
end;

procedure TRemoteProcessClient.WriteDouble(value: Double);
var
  pl: ^Int64;
  pd: ^Double;
  p: Pointer;

begin
  New(pd);
  pd^ := value;
  p := pd;
  pl := p;
  WriteLong(pl^);
  Dispose(pd);
end;

function TRemoteProcessClient.ReadDouble: Double;
var
  pl: ^Int64;
  pd: ^Double;
  p: Pointer;
    
begin
  New(pl);
  pl^ := ReadLong;
  p := pl;
  pd := p;
  result := pd^;
  Dispose(pl);
end;

procedure TRemoteProcessClient.WriteInt(value: LongInt);
var
  bytes: TByteArray;
  i: LongInt;
    
begin
  SetLength(bytes, INTEGER_SIZE_BYTES);
  for i := 0 to INTEGER_SIZE_BYTES - 1 do begin
    bytes[i] := (value shr ({24 -} i * 8)) and 255;
  end;

  if (IsLittleEndianMachine <> LITTLE_ENDIAN_BYTE_ORDER) then begin
    Reverse(bytes);
  end;

  WriteBytes(bytes);
  Finalize(bytes);
end;

procedure TRemoteProcessClient.WriteIntArray(value: TLongIntArray);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteInt(value[i]);
  end;
end;

procedure TRemoteProcessClient.WriteIntArray2D(value: TLongIntArray2D);
var
  i, len: LongInt;

begin
  if value = nil then begin
    WriteInt(-1);
    exit;
  end;

  len := Length(value);
  WriteInt(len);

  for i := 0 to len - 1 do begin
    WriteIntArray(value[i]);
  end;
end;

function TRemoteProcessClient.ReadInt: LongInt;
var
  bytes: TByteArray;
  res: LongInt;
  i: LongInt;
    
begin
  res := 0;
  bytes := readBytes(INTEGER_SIZE_BYTES);
  for i := INTEGER_SIZE_BYTES - 1 downto 0 do begin
    res := (res shl 8) or bytes[i];
  end;
        
  Finalize(bytes);
  result := res;
end;

function TRemoteProcessClient.ReadIntArray: TLongIntArray;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadInt;
  end;
end;

function TRemoteProcessClient.ReadIntArray2D: TLongIntArray2D;
var
  i, len: LongInt;

begin
  len := ReadInt;
  if len < 0 then begin
    result := nil;
    exit;
  end;

  SetLength(result, len);

  for i := 0 to len - 1 do begin
    result[i] := ReadIntArray;
  end;
end;

function TRemoteProcessClient.ReadLong: Int64;
var
  bytes: TByteArray;
  res: Int64;
  i: LongInt;
    
begin
  res := 0;
  bytes := readBytes(LONG_SIZE_BYTES);
  for i := LONG_SIZE_BYTES - 1 downto 0 do begin
    res := (res shl 8) or bytes[i];
  end;
        
  Finalize(bytes);
  result := res;
end;

procedure TRemoteProcessClient.WriteLong(value: Int64);
var
  bytes: TByteArray;
  i: LongInt;
    
begin
  SetLength(bytes, LONG_SIZE_BYTES);
  for i := 0 to LONG_SIZE_BYTES - 1 do begin
    bytes[i] := (value shr ({24 -} i*8)) and 255;
  end;

  if IsLittleEndianMachine <> LITTLE_ENDIAN_BYTE_ORDER then begin
    Reverse(bytes);
  end;

  WriteBytes(bytes);
  Finalize(bytes);
end;

function TRemoteProcessClient.IsLittleEndianMachine: Boolean;
begin
  result := true;
end;

procedure TRemoteProcessClient.Reverse(var bytes: TByteArray);
var
  i, len: LongInt;
  buffer: Byte;

begin
  len := Length(bytes);
  for i := 0 to (len div 2) do begin
    buffer := bytes[i];
    bytes[i] := bytes[len - i - 1];
    bytes[len - i - 1] := buffer;
  end;
end;

destructor TRemoteProcessClient.Destroy;
var
  playerIndex: LongInt;
  facilityIndex: LongInt;

begin
  FSocket.Free;

  if Assigned(FPreviousPlayers) then begin
    for playerIndex := High(FPreviousPlayers) downto 0 do begin
      if Assigned(FPreviousPlayers[playerIndex]) then begin
        FPreviousPlayers[playerIndex].Free;
      end;
    end;
  end;

  if Assigned(FPreviousFacilities) then begin
    for facilityIndex := High(FPreviousFacilities) downto 0 do begin
      if Assigned(FPreviousFacilities[facilityIndex]) then begin
        FPreviousFacilities[facilityIndex].Free;
      end;
    end;
  end;

  if Assigned(FPreviousPlayerById) then begin
    for playerIndex := High(FPreviousPlayerById) downto 0 do begin
      if Assigned(FPreviousPlayerById[playerIndex]) then begin
        FPreviousPlayerById[playerIndex].Free;
      end;
    end;
  end;

  if Assigned(FPreviousFacilityById) then begin
    for facilityIndex := High(FPreviousFacilityById) downto 0 do begin
      if Assigned(FPreviousFacilityById[facilityIndex]) then begin
        FPreviousFacilityById[facilityIndex].Free;
      end;
    end;
  end;
end;

end.
