# Mathematica SonarQube Test Project

A test project demonstrating SonarQube code quality analysis for Wolfram Mathematica code, including unit tests with native coverage generation.

## Overview

This project contains:
- **Sample Mathematica code** with intentional issues (bugs, security vulnerabilities, code smells)
- **Unit tests** using `VerificationTest`
- **Test runner** with native Wolfram coverage generation
- **SonarQube integration** for code quality analysis

## Project Structure

```
mathematica-sonarqube-test-project/
├── src/                          # Source files
│   ├── Calculator.wl             # Math functions with bugs and code smells
│   ├── StringUtils.wl            # String utilities with performance issues
│   └── SecurityIssues.wl         # Security vulnerabilities and hotspots
├── Tests/                        # Unit tests
│   ├── CalculatorTests.wl        # Tests for Calculator module
│   └── StringUtilsTests.wl       # Tests for StringUtils module
├── CoverageUtils.wl              # Reusable coverage export utility
├── RunTests.wl                   # Test runner with coverage tracking
├── Makefile                      # Build automation
├── sonar-project.properties      # SonarQube configuration
├── .gitignore                    # Git ignore patterns
└── README.md                     # This file
```

## Requirements

- **Wolfram Mathematica** 13.x or later (with `wolframscript`)
- **SonarQube** 9.9+ with the Mathematica plugin installed
- **sonar-scanner** command-line tool
- **Make** (for build automation)

## Quick Start

### 1. Run the Demo

```bash
make run
```

This loads the Mathematica modules and demonstrates basic functionality.

### 2. Run Unit Tests

```bash
make test
```

This runs all unit tests and generates coverage data in `./coverage/`.

### 3. Run SonarQube Scan

```bash
# Set environment variables
export SONARQUBE_HOME=/path/to/sonarqube
export SONAR_TOKEN=your_token_here

# Run scan
make scan
```

View results at http://localhost:9000

### 4. Get Help

```bash
make help
```

## Makefile Targets

| Target | Description |
|--------|-------------|
| `make` or `make help` | Show available targets and usage |
| `make test` | Run Wolfram unit tests with coverage |
| `make scan` | Run SonarQube code analysis |
| `make run` | Run the Mathematica demo program |
| `make clean` | Clean generated files |

## Environment Variables

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `MATHEMATICA_HOME` | Path to Mathematica installation | *(searches PATH)* | `/Applications/Mathematica.app/Contents` |
| `SONARQUBE_HOME` | Path to SonarQube installation | `/usr/local/sonarqube` | `/usr/local/sonarqube` |
| `SONAR_TOKEN` | SonarQube authentication token | *(required for scan)* | `sqp_abc123...` |
| `SONAR_HOST_URL` | SonarQube server URL | `http://localhost:9000` | `http://localhost:9000` |

## What Issues Will SonarQube Find?

This project intentionally includes various code quality issues:

### Security Vulnerabilities (12+)
- Command injection (`ExecuteUserCommand`)
- SQL injection (`QueryDatabase`)
- Hardcoded credentials (`ConnectToDatabase`)
- XSS potential (`GenerateHTML`)
- Path traversal (`ReadUserFile`)
- Eval of user input (`EvaluateUserCode`)

### Security Hotspots (5+)
- Weak cryptography (MD5, CRC32)
- Weak random number generation
- Disabled certificate validation
- World-writable file permissions
- Debug code in production

### Bugs (15+)
- Division by zero (`Divide`)
- Infinite recursion (`Factorial`)
- Missing empty list check (`Average`)
- Assignment in conditional (`UpdateAndCheck`)
- Type mismatch (`AddToString`)
- Off-by-one errors (`GetFirstN`)
- Missing memoization (`Fibonacci`)

### Code Smells (25+)
- AppendTo in loop (`ProcessData`)
- String concatenation in loop (`BuildString`)
- Complex boolean expressions (`ComplexCondition`)
- Identical branches (`CheckValue`)
- Double negation (`IsNotNegative`)
- Double transpose (`TransposeMatrix`)
- Floating point equality (`IsOne`)
- Global context pollution
- Hardcoded file paths
- Unused variables
- Empty blocks
- Performance anti-patterns

## Test Coverage

The project uses Mathematica's native test framework:

1. **Tests** are written using `VerificationTest`
2. **Test runner** (`RunTests.wl`) executes all tests
3. **Coverage data** is generated in native Wolfram format
4. **Coverage files** are exported to `./coverage/`:
   - `coverage-raw.wl` - Native Wolfram format
   - `coverage.json` - JSON format (for SonarQube plugin)
   - `test-results.json` - Test execution results

### CoverageUtils.wl - Reusable Coverage Utility

This project includes `CoverageUtils.wl`, a reusable package for exporting Mathematica coverage data to JSON format compatible with the SonarQube Mathematica plugin.

**Features:**
- Converts nested Wolfram Association structures to clean JSON
- Validates coverage data structure before export
- Includes line-by-line hit counts and coverage percentages
- Handles large datasets efficiently (removes source code from line data)

**Usage in your own projects:**

```mathematica
(* Load the utility *)
Get["CoverageUtils.wl"]

(* Export your coverage data *)
CoverageUtils`ExportCoverageJSON[coverageData, "coverage/coverage.json"]
```

**Required data structure:**
```mathematica
coverageData = <|
  "/path/to/file.wl" -> <|
    "FileName" -> "MyModule",
    "FullPath" -> "/path/to/file.wl",
    "TotalLines" -> 100,
    "CodeLines" -> 75,
    "CoveredLines" -> 50,
    "Coverage" -> 0.667,
    "LineCoverage" -> <|
      1 -> <|"Line"->1, "IsCode"->True, "Hits"->5|>,
      2 -> <|"Line"->2, "IsCode"->False, "Hits"->0|>,
      (* ... *)
    |>
  |>
|>
```

The utility is licensed under **GPLv3** and can be freely used in your Mathematica projects. See `CoverageUtils.wl` for complete documentation and examples.

## SonarQube Configuration

The project is configured via `sonar-project.properties`:

```properties
sonar.projectKey=mathematica-test-project
sonar.sources=src
sonar.tests=Tests
sonar.inclusions=**/*.wl,**/*.m,**/*.wls
```

## Development Workflow

1. **Write code** in `src/`
2. **Write tests** in `Tests/`
3. **Run tests** with `make test`
4. **Run scan** with `make scan`
5. **Fix issues** identified by SonarQube
6. **Repeat** until quality gate passes

## Example: Running a Complete Analysis

```bash
# 1. Clone the repository
cd ~/dev/mathematica-sonarqube-test-project

# 2. Run unit tests
make test

# 3. Set up environment
export SONARQUBE_HOME=/usr/local/sonarqube
export SONAR_TOKEN=sqp_abc123...

# 4. Run SonarQube scan
make scan

# 5. View results in browser
open http://localhost:9000/dashboard?id=mathematica-test-project
```

## Expected SonarQube Results

When you run the scan, you should see approximately:

- **40-50 issues** detected
- **12+ vulnerabilities**
- **5+ security hotspots**
- **15+ bugs**
- **25+ code smells**
- **Code coverage**: *(awaiting converter implementation)*

## Troubleshooting

### `wolframscript not found`

If you see this error, set the `MATHEMATICA_HOME` environment variable:

```bash
# macOS
export MATHEMATICA_HOME=/Applications/Mathematica.app/Contents
make test

# Linux
export MATHEMATICA_HOME=/usr/local/Wolfram/Mathematica/13.0
make test

# Or run inline:
MATHEMATICA_HOME=/Applications/Mathematica.app/Contents make run
```

Alternatively, add `wolframscript` to your PATH.

### `sonar-scanner not found`

Install sonar-scanner or add it to PATH:
```bash
export PATH=$SONARQUBE_HOME/bin:$PATH
```

### Authentication Errors

Make sure `SONAR_TOKEN` is set:
```bash
export SONAR_TOKEN=$(cat ~/.sonarqube-token)
```

### No Issues Found

Verify the Mathematica plugin is installed:
1. Go to SonarQube → Administration → Marketplace
2. Search for "Mathematica"
3. Install if not already installed
4. Restart SonarQube

## Next Steps

1. ✅ Run tests and scan
2. ✅ Review SonarQube results
3. ⏳ Implement coverage converter (Wolfram → lcov)
4. ⏳ Add more test cases
5. ⏳ Fix identified issues

## Contributing

This is a test/demo project. Feel free to:
- Add more code examples
- Add more test cases
- Improve the coverage converter
- Document additional issues

## License

This is a demonstration project. Use as you wish.

## Resources

- [SonarQube Mathematica Plugin](https://github.com/bceverly/sonar-mathematica-plugin)
- [SonarQube Documentation](https://docs.sonarqube.org/)
- [Wolfram Language Documentation](https://reference.wolfram.com/)
