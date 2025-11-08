(* ::Package:: *)

(* StringUtils.wl - String utilities with performance and maintainability issues *)

BeginPackage["StringUtils`"]

StrToUpper::usage = "StrToUpper[str] converts string to uppercase."
ReverseString::usage = "ReverseString[str] reverses a string."
CountWords::usage = "CountWords[str] counts words in a string."
FormatList::usage = "FormatList[list] formats a list as comma-separated string."

Begin["`Private`"]

(* CODE SMELL: Double transpose *)
TransposeMatrix[m_] := Transpose[Transpose[m]]

(* CODE SMELL: Double reverse *)
ReverseReverse[list_] := Reverse[Reverse[list]]

(* Good: Simple string reversal *)
ReverseString[str_String] := StringReverse[str]

(* Good: Simple uppercase *)
StrToUpper[str_String] := ToUpperCase[str]

(* BUG: Type mismatch - trying to add string and number *)
AddToString[str_String, n_] := str + n

(* CODE SMELL: Off-by-one error *)
GetFirstN[list_, n_] := Table[list[[i]], {i, 0, n}]

(* CODE SMELL: Missing pattern test *)
SquareRoot[x_] := Sqrt[x]

(* PERFORMANCE: Linear search instead of lookup *)
FindValue[key_String, data_List] := Module[{result = Null},
  Do[
    If[data[[i, 1]] == key, result = data[[i, 2]]],
    {i, Length[data]}
  ];
  result
]

(* CODE SMELL: Empty block *)
DoNothing[] := Module[{x}]

(* CODE SMELL: Unused variable *)
CalculateSum[a_, b_] := Module[{unused = 42, result},
  result = a + b;
  result
]

(* CODE SMELL: Global context pollution *)
Global`myGlobalVar = 123;

(* PERFORMANCE: Flatten[Table[...]] antipattern *)
GenerateSquares[n_] := Flatten[Table[i^2, {i, n}]]

(* CODE SMELL: Nested Map/Table *)
ProcessMatrix[m_] := Map[Function[row, Map[Function[x, x^2], row]], m]

(* CODE SMELL: Comparison with Null *)
IsNull[x_] := x == Null

(* CODE SMELL: Empty catch block *)
SafeDivide[x_, y_] := Quiet[x / y]

(* CODE SMELL: Repeated part extraction *)
GetCoordinates[point_] := {point[[1]], point[[1]], point[[2]]}

(* PERFORMANCE: DeleteDuplicates on large data without sorting *)
RemoveDuplicates[largeList_] := DeleteDuplicates[largeList]

(* CODE SMELL: Identity operation *)
AddZero[x_] := x + 0

(* CODE SMELL: SetDelayed vs Set confusion *)
Square[x_] = x^2

(* CODE SMELL: Block/Module misuse *)
TestScope[x_] := Block[{y}, y = x + 1; y]

(* BUG: Missing memoization for recursive function *)
Fibonacci[0] := 0
Fibonacci[1] := 1
Fibonacci[n_] := Fibonacci[n - 1] + Fibonacci[n - 2]

(* CODE SMELL: Hardcoded file path *)
LoadConfig[] := Import["/Users/admin/config.txt"]

End[]

EndPackage[]
