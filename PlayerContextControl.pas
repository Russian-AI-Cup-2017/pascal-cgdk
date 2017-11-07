unit PlayerContextControl;

interface

uses
  Math, TypeControl, PlayerControl, WorldControl;

type
  TPlayerContext = class
  private
    FPlayer: TPlayer;
    FWorld: TWorld;

  public
    constructor Create(const player: TPlayer; const world: TWorld);

    function GetPlayer: TPlayer;
    property Player: TPlayer read GetPlayer;
    function GetWorld: TWorld;
    property World: TWorld read GetWorld;

    destructor Destroy; override;

  end;

  TPlayerContextArray = array of TPlayerContext;

implementation

constructor TPlayerContext.Create(const player: TPlayer; const world: TWorld);
begin
  FPlayer := player;
  FWorld := world;
end;

function TPlayerContext.GetPlayer: TPlayer;
begin
  result := FPlayer;
end;

function TPlayerContext.GetWorld: TWorld;
begin
  result := FWorld;
end;

destructor TPlayerContext.Destroy;
begin
  if Assigned(FPlayer) then begin
    FPlayer.Free;
  end;

  if Assigned(FWorld) then begin
    FWorld.Free;
  end;

  inherited;
end;

end.
