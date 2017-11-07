uses
  SysUtils, RemoteProcessClient, StrategyControl, MyStrategy,
  PlayerControl, PlayerContextControl, MoveControl, GameControl;

type
  TRunner = class
  private
    FRemoteProcessClient: TRemoteProcessClient;
    FToken: String;

  public
    constructor Create(arguments: array of String);

    procedure Run;

    destructor Destroy; override;

  end;

constructor TRunner.Create(arguments: array of String);
begin
  if Length(arguments) = 4 then begin
    FRemoteProcessClient := TRemoteProcessClient.Create(arguments[1], StrToInt(arguments[2]));
    FToken := arguments[3];
  end else begin
    FRemoteProcessClient := TRemoteProcessClient.Create('127.0.0.1', 31001);
    FToken := '0000000000000000';
  end;
end;

procedure TRunner.Run;
var
  game: TGame;
  move: TMove;
  player: TPlayer;
  playerContext: TPlayerContext;
  strategy: TStrategy;

begin
  FRemoteProcessClient.WriteTokenMessage(FToken);
  FRemoteProcessClient.WriteProtocolVersionMessage;
  FRemoteProcessClient.ReadTeamSizeMessage;
  game := FRemoteProcessClient.ReadGameContextMessage;

  strategy := TMyStrategy.Create;

  while true do begin
    playerContext := FRemoteProcessClient.ReadPlayerContextMessage;
    if playerContext = nil then begin
      break;
    end;

    player := playerContext.Player;
    if player = nil then begin
      break;
    end;

    move := TMove.Create;
    strategy.Move(player, playerContext.World, game, move);

    FRemoteProcessClient.WriteMoveMessage(move);

    move.Free;
    playerContext.Free;
  end;

  strategy.Free;
end;

destructor TRunner.Destroy;
begin
  FRemoteProcessClient.Free;

  inherited;
end;

var
  i: LongInt;
  runner: TRunner;
  arguments: array of String;

begin
  try
    SetLength(arguments, paramCount + 1);

    for i := 0 to paramCount do begin
      arguments[i] := ParamStr(i);
    end;

    runner := TRunner.Create(arguments);
    runner.Run;
    runner.Free;

    SetLength(arguments, 0);
  except
    on E: Exception do begin
      WriteLn('Exception occured: type=', E.ClassName, ', message="', E.Message, '".');
      HALT(239);
    end;
  end;
end.
