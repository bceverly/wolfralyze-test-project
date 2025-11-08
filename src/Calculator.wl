(* ::Package:: *)

(* Calculator.wl - Basic math operations with some intentional issues *)

BeginPackage["Calculator`"]

Add::usage = "Add[x, y] adds two numbers."
Subtract::usage = "Subtract[x, y] subtracts y from x."
Multiply::usage = "Multiply[x, y] multiplies two numbers."
Divide::usage = "Divide[x, y] divides x by y."
CalcFactorial::usage = "CalcFactorial[n] calculates factorial recursively."
Average::usage = "Average[list] calculates the average of a list."
ProcessData::usage = "ProcessData[data] processes a list of data."

Begin["`Private`"]

(* Good: Simple addition *)
Add[x_, y_] := x + y

(* Good: Simple subtraction *)
Subtract[x_, y_] := x - y

(* Good: Simple multiplication *)
Multiply[x_, y_] := x * y

(* BUG: Division without zero check - will trigger ZeroDenominator issue *)
Divide[x_, y_] := x / y

(* BUG: Infinite recursion - no base case! *)
CalcFactorial[n_] := n * CalcFactorial[n - 1]

(* CODE SMELL: AppendTo in loop - major performance issue *)
ProcessData[data_List] := Module[{result = {}},
  Do[
    result = Append[result, data[[i]]^2],
    {i, Length[data]}
  ];
  result
]

(* BUG: Missing empty list check *)
Average[list_List] := Total[list] / Length[list]

(* CODE SMELL: Complex boolean expression *)
ComplexCondition[a_, b_, c_, d_, e_] :=
  If[a > 0 && b < 10 && c != 0 && d >= 5 && e <= 100,
    "Valid",
    "Invalid"
  ]

(* CODE SMELL: Identical branches *)
CheckValue[x_] := If[x > 0, "positive", "positive"]

(* CODE SMELL: Double negation *)
IsNotNegative[x_] := Not[Not[x >= 0]]

(* BUG: Assignment in conditional *)
UpdateAndCheck[x_] := If[y = x + 1, y, 0]

(* CODE SMELL: Floating point equality *)
IsOne[x_] := x == 1.0

(* CODE SMELL: String concatenation in loop *)
BuildString[n_] := Module[{str = ""},
  Do[
    str = str <> ToString[i] <> ",",
    {i, n}
  ];
  str
]

End[]

EndPackage[]
