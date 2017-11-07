unit VehicleTypeControl;

interface

uses
  TypeControl;

const
  _VEHICLE_UNKNOWN_ : LongInt = -1;
  VEHICLE_ARRV      : LongInt = 0;
  VEHICLE_FIGHTER   : LongInt = 1;
  VEHICLE_HELICOPTER: LongInt = 2;
  VEHICLE_IFV       : LongInt = 3;
  VEHICLE_TANK      : LongInt = 4;
  _VEHICLE_COUNT_   : LongInt = 5;

type
  TVehicleType = LongInt;
  TVehicleTypeArray = TLongIntArray;
  TVehicleTypeArray2D = TLongIntArray2D;
  TVehicleTypeArray3D = TLongIntArray3D;
  TVehicleTypeArray4D = TLongIntArray4D;
  TVehicleTypeArray5D = TLongIntArray5D;

implementation

end.
