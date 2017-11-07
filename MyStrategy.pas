unit MyStrategy;

interface

uses
  StrategyControl, TypeControl, ActionTypeControl, CircularUnitControl, FacilityControl, FacilityTypeControl,
  GameControl, MoveControl, PlayerContextControl, PlayerControl, TerrainTypeControl, UnitControl, VehicleControl,
  VehicleTypeControl, VehicleUpdateControl, WeatherTypeControl, WorldControl;

type
  TMyStrategy = class (TStrategy)
  public
    procedure Move(me: TPlayer; world: TWorld; game: TGame; move: TMove); override;

  end;

implementation

uses
  Math;
    
procedure TMyStrategy.Move(me: TPlayer; world: TWorld; game: TGame; move: TMove);
begin
  if world.TickIndex = 0 then begin
    move.Action := ACTION_CLEAR_AND_SELECT;
    move.Right := world.Width;
    move.Bottom := world.Height;
    exit;
  end;

  if world.TickIndex = 1 then begin
    move.Action := ACTION_MOVE;
    move.X := world.Width / 2.0;
    move.Y := world.Height / 2.0;
  end;
end;

end.
