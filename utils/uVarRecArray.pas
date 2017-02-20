unit uVarRecArray;

interface

type

  TVarRecArray = Array of TVarRec;

  procedure CreateVRA(var VRA: TVarRecArray; const Args: Array of Const);
  procedure DisposeVRA(var VRA: TVarRecArray);

implementation

procedure CreateVRA(var VRA: TVarRecArray; const Args: Array of Const);
var 
  I, C : Integer;
begin
  DisposeVRA(VRA);
  C := Length(VRA);
  SetLength(VRA, C+Length(Args));
  for I := 0 to High(Args) do with Args[I] do begin
    VRA[C].VType := VType;
    case VType of 
      vtInteger:    VRA[C].VInteger := VInteger;
      vtBoolean:    VRA[C].VBoolean := VBoolean;
procedure DisposeVRA(var VRA: TVarRecArray);
var I : Integer;
begin
  for I := 0 to High(VRA) do with VRA[I] do
  case VType of
	 vtExtended:   Dispose(VExtended);
	 vtString:     Dispose(VString);
end;



end.