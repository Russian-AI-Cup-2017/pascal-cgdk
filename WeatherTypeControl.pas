unit WeatherTypeControl;

interface

uses
  TypeControl;

const
  _WEATHER_UNKNOWN_: LongInt = -1;
  WEATHER_CLEAR    : LongInt = 0;
  WEATHER_CLOUD    : LongInt = 1;
  WEATHER_RAIN     : LongInt = 2;
  _WEATHER_COUNT_  : LongInt = 3;

type
  TWeatherType = LongInt;
  TWeatherTypeArray = TLongIntArray;
  TWeatherTypeArray2D = TLongIntArray2D;
  TWeatherTypeArray3D = TLongIntArray3D;
  TWeatherTypeArray4D = TLongIntArray4D;
  TWeatherTypeArray5D = TLongIntArray5D;

implementation

end.
