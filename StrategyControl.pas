unit StrategyControl;

interface

uses
  PlayerControl, WorldControl, GameControl, MoveControl;

type
  TStrategy = class
  public
    constructor Create; virtual;
    procedure Move(me: TPlayer; world: TWorld; game: TGame; move: TMove); virtual; abstract;

  end;

implementation

constructor TStrategy.Create;
begin
  inherited Create;
end;

end.
