(* ::Package:: *)

(* SecurityIssues.wl - Intentional security vulnerabilities and hotspots *)

BeginPackage["SecurityIssues`"]

ExecuteUserCommand::usage = "ExecuteUserCommand[cmd] executes a user-provided command."
QueryDatabase::usage = "QueryDatabase[userId] queries database with user input."
ConnectToDatabase::usage = "ConnectToDatabase[] connects with hardcoded credentials."
EncryptData::usage = "EncryptData[data] encrypts data with weak algorithm."
GenerateToken::usage = "GenerateToken[] generates a random token."
ValidateInput::usage = "ValidateInput[input] validates user input."

Begin["`Private`"]

(* SECURITY VULNERABILITY: Command injection *)
ExecuteUserCommand[cmd_String] := RunProcess[{"sh", "-c", cmd}]

(* SECURITY VULNERABILITY: SQL injection *)
QueryDatabase[userId_String] :=
  JDBCConnection["jdbc:mysql://localhost/mydb"]@
    SQLExecute["SELECT * FROM users WHERE id = " <> userId]

(* SECURITY VULNERABILITY: Hardcoded credentials *)
ConnectToDatabase[] := Module[{},
  password = "admin123";
  apiKey = "sk-1234567890abcdef";
  DatabaseConnect[{
    "Username" -> "root",
    "Password" -> password,
    "APIKey" -> apiKey
  }]
]

(* SECURITY HOTSPOT: Weak cryptography *)
EncryptData[data_String] := Hash[data, "MD5"]

(* SECURITY HOTSPOT: Weak random number generation *)
GenerateToken[] := ToString[RandomInteger[{1, 1000000}]]

(* SECURITY VULNERABILITY: Path traversal *)
ReadUserFile[filename_String] := Import["/var/data/" <> filename]

(* SECURITY VULNERABILITY: XSS potential *)
GenerateHTML[userInput_String] :=
  "<html><body><h1>" <> userInput <> "</h1></body></html>"

(* SECURITY HOTSPOT: Disabled certificate validation *)
FetchURL[url_String] := URLRead[url, "VerifySecurityCertificates" -> False]

(* SECURITY VULNERABILITY: Eval of user input *)
EvaluateUserCode[code_String] := ToExpression[code]

(* SECURITY HOTSPOT: World-writable file *)
SaveData[data_] := Export["/tmp/data.txt", data, "Permissions" -> 8^^777]

(* CODE SMELL: Debug code left in production *)
ValidateInput[input_] := (
  Print["DEBUG: input = ", input];
  StringLength[input] > 0
)

(* SECURITY VULNERABILITY: Use of deprecated insecure function *)
OldHash[data_] := Hash[data, "CRC32"]

End[]

EndPackage[]
