unit FacilityTypeControl;

interface

uses
  TypeControl;

const
  _FACILITY_UNKNOWN_      : LongInt = -1;
  FACILITY_CONTROL_CENTER : LongInt = 0;
  FACILITY_VEHICLE_FACTORY: LongInt = 1;
  _FACILITY_COUNT_        : LongInt = 2;

type
  TFacilityType = LongInt;
  TFacilityTypeArray = TLongIntArray;
  TFacilityTypeArray2D = TLongIntArray2D;
  TFacilityTypeArray3D = TLongIntArray3D;
  TFacilityTypeArray4D = TLongIntArray4D;
  TFacilityTypeArray5D = TLongIntArray5D;

implementation

end.
