(* ::Package:: *)

(* StringUtilsTests.wl - Unit tests for StringUtils module *)

(* Load the StringUtils package *)
Get[FileNameJoin[{DirectoryName[$InputFileName], "..", "src", "StringUtils.wl"}]]

(* Test ReverseString function *)
VerificationTest[
  StringUtils`ReverseString["hello"],
  "olleh",
  TestID -> "ReverseString-Basic"
]

VerificationTest[
  StringUtils`ReverseString[""],
  "",
  TestID -> "ReverseString-Empty"
]

(* Test ToUpperCase function *)
VerificationTest[
  StringUtils`ToUpperCase["hello"],
  "HELLO",
  TestID -> "ToUpperCase-Basic"
]

(* Test TransposeMatrix function *)
VerificationTest[
  StringUtils`TransposeMatrix[{{1, 2}, {3, 4}}],
  {{1, 2}, {3, 4}},
  TestID -> "TransposeMatrix-Square"
]

(* Test ReverseReverse function *)
VerificationTest[
  StringUtils`ReverseReverse[{1, 2, 3}],
  {1, 2, 3},
  TestID -> "ReverseReverse-Basic"
]

(* Test CalculateSum function *)
VerificationTest[
  StringUtils`CalculateSum[5, 3],
  8,
  TestID -> "CalculateSum-Basic"
]

(* Test GenerateSquares function *)
VerificationTest[
  StringUtils`GenerateSquares[5],
  {1, 4, 9, 16, 25},
  TestID -> "GenerateSquares-Basic"
]

(* Test ProcessMatrix function *)
VerificationTest[
  StringUtils`ProcessMatrix[{{1, 2}, {3, 4}}],
  {{1, 4}, {9, 16}},
  TestID -> "ProcessMatrix-Basic"
]

(* Test IsNull function *)
VerificationTest[
  StringUtils`IsNull[Null],
  True,
  TestID -> "IsNull-True"
]

VerificationTest[
  StringUtils`IsNull[5],
  False,
  TestID -> "IsNull-False"
]

(* Test SafeDivide function *)
VerificationTest[
  StringUtils`SafeDivide[10, 2],
  5,
  TestID -> "SafeDivide-Basic"
]

(* Test AddZero function *)
VerificationTest[
  StringUtils`AddZero[42],
  42,
  TestID -> "AddZero-Basic"
]

(* Test Square function *)
VerificationTest[
  StringUtils`Square[5],
  25,
  TestID -> "Square-Basic"
]

(* Test Fibonacci function *)
VerificationTest[
  StringUtils`Fibonacci[0],
  0,
  TestID -> "Fibonacci-Zero"
]

VerificationTest[
  StringUtils`Fibonacci[1],
  1,
  TestID -> "Fibonacci-One"
]

VerificationTest[
  StringUtils`Fibonacci[5],
  5,
  TestID -> "Fibonacci-Five"
]

(* Test GetCoordinates function *)
VerificationTest[
  StringUtils`GetCoordinates[{10, 20}],
  {10, 10, 20},
  TestID -> "GetCoordinates-Basic"
]
