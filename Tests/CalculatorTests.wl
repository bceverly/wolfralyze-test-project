(* ::Package:: *)

(* CalculatorTests.wl - Unit tests for Calculator module *)

(* Load the Calculator package *)
Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "src", "Calculator.wl"}]]

(* Test Add function *)
VerificationTest[
  Calculator`Add[2, 3],
  5,
  TestID -> "Add-Basic"
]

VerificationTest[
  Calculator`Add[-5, 10],
  5,
  TestID -> "Add-Negative"
]

VerificationTest[
  Calculator`Add[0, 0],
  0,
  TestID -> "Add-Zero"
]

(* Test Subtract function *)
VerificationTest[
  Calculator`Subtract[10, 3],
  7,
  TestID -> "Subtract-Basic"
]

VerificationTest[
  Calculator`Subtract[5, 10],
  -5,
  TestID -> "Subtract-Negative"
]

(* Test Multiply function *)
VerificationTest[
  Calculator`Multiply[4, 5],
  20,
  TestID -> "Multiply-Basic"
]

VerificationTest[
  Calculator`Multiply[0, 100],
  0,
  TestID -> "Multiply-Zero"
]

VerificationTest[
  Calculator`Multiply[-3, 4],
  -12,
  TestID -> "Multiply-Negative"
]

(* Test Divide function *)
VerificationTest[
  Calculator`Divide[10, 2],
  5,
  TestID -> "Divide-Basic"
]

VerificationTest[
  Calculator`Divide[7, 2],
  7/2,
  TestID -> "Divide-Fraction"
]

(* Test ProcessData function *)
VerificationTest[
  Calculator`ProcessData[{1, 2, 3}],
  {1, 4, 9},
  TestID -> "ProcessData-Basic"
]

VerificationTest[
  Calculator`ProcessData[{}],
  {},
  TestID -> "ProcessData-Empty"
]

(* Test Average function - note: this will fail for empty lists *)
VerificationTest[
  Calculator`Average[{1, 2, 3, 4, 5}],
  3,
  TestID -> "Average-Basic"
]

VerificationTest[
  Calculator`Average[{10, 20}],
  15,
  TestID -> "Average-Two"
]

(* Test ComplexCondition function *)
VerificationTest[
  Calculator`ComplexCondition[1, 5, 1, 10, 50],
  "Valid",
  TestID -> "ComplexCondition-Valid"
]

VerificationTest[
  Calculator`ComplexCondition[0, 5, 1, 10, 50],
  "Invalid",
  TestID -> "ComplexCondition-Invalid"
]

(* Test CheckValue function *)
VerificationTest[
  Calculator`CheckValue[5],
  "positive",
  TestID -> "CheckValue-Positive"
]

(* Test IsNotNegative function *)
VerificationTest[
  Calculator`IsNotNegative[5],
  True,
  TestID -> "IsNotNegative-Positive"
]

VerificationTest[
  Calculator`IsNotNegative[-5],
  False,
  TestID -> "IsNotNegative-Negative"
]

(* Test IsOne function *)
VerificationTest[
  Calculator`IsOne[1.0],
  True,
  TestID -> "IsOne-True"
]

(* Test BuildString function *)
VerificationTest[
  StringLength[Calculator`BuildString[10]] > 0,
  True,
  TestID -> "BuildString-NonEmpty"
]
