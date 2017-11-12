unit PlayerControl;

interface

uses
  Math, TypeControl;

type
  TPlayer = class
  private
    FId: Int64;
    FMe: Boolean;
    FStrategyCrashed: Boolean;
    FScore: LongInt;
    FRemainingActionCooldownTicks: LongInt;
    FRemainingNuclearStrikeCooldownTicks: LongInt;
    FNextNuclearStrikeVehicleId: Int64;
    FNextNuclearStrikeTickIndex: LongInt;
    FNextNuclearStrikeX: Double;
    FNextNuclearStrikeY: Double;

  public
    constructor Create(const id: Int64; const me: Boolean; const strategyCrashed: Boolean; const score: LongInt;
      const remainingActionCooldownTicks: LongInt; const remainingNuclearStrikeCooldownTicks: LongInt;
      const nextNuclearStrikeVehicleId: Int64; const nextNuclearStrikeTickIndex: LongInt;
      const nextNuclearStrikeX: Double; const nextNuclearStrikeY: Double); overload;
    constructor Create(const player: TPlayer); overload;

    function GetId: Int64;
    property Id: Int64 read GetId;
    function GetMe: Boolean;
    property IsMe: Boolean read GetMe;
    function GetStrategyCrashed: Boolean;
    property IsStrategyCrashed: Boolean read GetStrategyCrashed;
    function GetScore: LongInt;
    property Score: LongInt read GetScore;
    function GetRemainingActionCooldownTicks: LongInt;
    property RemainingActionCooldownTicks: LongInt read GetRemainingActionCooldownTicks;
    function GetRemainingNuclearStrikeCooldownTicks: LongInt;
    property RemainingNuclearStrikeCooldownTicks: LongInt read GetRemainingNuclearStrikeCooldownTicks;
    function GetNextNuclearStrikeVehicleId: Int64;
    property NextNuclearStrikeVehicleId: Int64 read GetNextNuclearStrikeVehicleId;
    function GetNextNuclearStrikeTickIndex: LongInt;
    property NextNuclearStrikeTickIndex: LongInt read GetNextNuclearStrikeTickIndex;
    function GetNextNuclearStrikeX: Double;
    property NextNuclearStrikeX: Double read GetNextNuclearStrikeX;
    function GetNextNuclearStrikeY: Double;
    property NextNuclearStrikeY: Double read GetNextNuclearStrikeY;

    destructor Destroy; override;

  end;

  TPlayerArray = array of TPlayer;

implementation

constructor TPlayer.Create(const id: Int64; const me: Boolean; const strategyCrashed: Boolean; const score: LongInt;
  const remainingActionCooldownTicks: LongInt; const remainingNuclearStrikeCooldownTicks: LongInt;
  const nextNuclearStrikeVehicleId: Int64; const nextNuclearStrikeTickIndex: LongInt; const nextNuclearStrikeX: Double;
  const nextNuclearStrikeY: Double);
begin
  FId := id;
  FMe := me;
  FStrategyCrashed := strategyCrashed;
  FScore := score;
  FRemainingActionCooldownTicks := remainingActionCooldownTicks;
  FRemainingNuclearStrikeCooldownTicks := remainingNuclearStrikeCooldownTicks;
  FNextNuclearStrikeVehicleId := nextNuclearStrikeVehicleId;
  FNextNuclearStrikeTickIndex := nextNuclearStrikeTickIndex;
  FNextNuclearStrikeX := nextNuclearStrikeX;
  FNextNuclearStrikeY := nextNuclearStrikeY;
end;

constructor TPlayer.Create(const player: TPlayer);
begin
  FId := player.Id;
  FMe := player.IsMe;
  FStrategyCrashed := player.IsStrategyCrashed;
  FScore := Score;
  FRemainingActionCooldownTicks := player.RemainingActionCooldownTicks;
  FRemainingNuclearStrikeCooldownTicks := player.RemainingNuclearStrikeCooldownTicks;
  FNextNuclearStrikeVehicleId := player.NextNuclearStrikeVehicleId;
  FNextNuclearStrikeTickIndex := player.NextNuclearStrikeTickIndex;
  FNextNuclearStrikeX := player.NextNuclearStrikeX;
  FNextNuclearStrikeY := player.NextNuclearStrikeY;
end;

function TPlayer.GetId: Int64;
begin
  result := FId;
end;

function TPlayer.GetMe: Boolean;
begin
  result := FMe;
end;

function TPlayer.GetStrategyCrashed: Boolean;
begin
  result := FStrategyCrashed;
end;

function TPlayer.GetScore: LongInt;
begin
  result := FScore;
end;

function TPlayer.GetRemainingActionCooldownTicks: LongInt;
begin
  result := FRemainingActionCooldownTicks;
end;

function TPlayer.GetRemainingNuclearStrikeCooldownTicks: LongInt;
begin
  result := FRemainingNuclearStrikeCooldownTicks;
end;

function TPlayer.GetNextNuclearStrikeVehicleId: Int64;
begin
  result := FNextNuclearStrikeVehicleId;
end;

function TPlayer.GetNextNuclearStrikeTickIndex: LongInt;
begin
  result := FNextNuclearStrikeTickIndex;
end;

function TPlayer.GetNextNuclearStrikeX: Double;
begin
  result := FNextNuclearStrikeX;
end;

function TPlayer.GetNextNuclearStrikeY: Double;
begin
  result := FNextNuclearStrikeY;
end;

destructor TPlayer.Destroy;
begin
  inherited;
end;

end.
