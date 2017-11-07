unit TerrainTypeControl;

interface

uses
  TypeControl;

const
  _TERRAIN_UNKNOWN_: LongInt = -1;
  TERRAIN_PLAIN    : LongInt = 0;
  TERRAIN_SWAMP    : LongInt = 1;
  TERRAIN_FOREST   : LongInt = 2;
  _TERRAIN_COUNT_  : LongInt = 3;

type
  TTerrainType = LongInt;
  TTerrainTypeArray = TLongIntArray;
  TTerrainTypeArray2D = TLongIntArray2D;
  TTerrainTypeArray3D = TLongIntArray3D;
  TTerrainTypeArray4D = TLongIntArray4D;
  TTerrainTypeArray5D = TLongIntArray5D;

implementation

end.
