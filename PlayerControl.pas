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

  public
    constructor Create(const id: Int64; const me: Boolean; const strategyCrashed: Boolean; const score: LongInt;
      const remainingActionCooldownTicks: LongInt); overload;
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

    destructor Destroy; override;

  end;

  TPlayerArray = array of TPlayer;

implementation

constructor TPlayer.Create(const id: Int64; const me: Boolean; const strategyCrashed: Boolean; const score: LongInt;
  const remainingActionCooldownTicks: LongInt);
begin
  FId := id;
  FMe := me;
  FStrategyCrashed := strategyCrashed;
  FScore := score;
  FRemainingActionCooldownTicks := remainingActionCooldownTicks;
end;

constructor TPlayer.Create(const player: TPlayer);
begin
  FId := player.Id;
  FMe := player.IsMe;
  FStrategyCrashed := player.IsStrategyCrashed;
  FScore := Score;
  FRemainingActionCooldownTicks := player.RemainingActionCooldownTicks;
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

destructor TPlayer.Destroy;
begin
  inherited;
end;

end.
