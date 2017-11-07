unit ActionTypeControl;

interface

uses
  TypeControl;

const
  _ACTION_UNKNOWN_               : LongInt = -1;
  ACTION_NONE                    : LongInt = 0;
  ACTION_CLEAR_AND_SELECT        : LongInt = 1;
  ACTION_ADD_TO_SELECTION        : LongInt = 2;
  ACTION_DESELECT                : LongInt = 3;
  ACTION_ASSIGN                  : LongInt = 4;
  ACTION_DISMISS                 : LongInt = 5;
  ACTION_DISBAND                 : LongInt = 6;
  ACTION_MOVE                    : LongInt = 7;
  ACTION_ROTATE                  : LongInt = 8;
  ACTION_SETUP_VEHICLE_PRODUCTION: LongInt = 9;
  _ACTION_COUNT_                 : LongInt = 10;

type
  TActionType = LongInt;
  TActionTypeArray = TLongIntArray;
  TActionTypeArray2D = TLongIntArray2D;
  TActionTypeArray3D = TLongIntArray3D;
  TActionTypeArray4D = TLongIntArray4D;
  TActionTypeArray5D = TLongIntArray5D;

implementation

end.
