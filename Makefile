.PHONY: help test scan run clean

# Default target
.DEFAULT_GOAL := help

# Environment variables
SONARQUBE_HOME ?= /usr/local/sonarqube
SONAR_TOKEN ?=
SONAR_HOST_URL ?= http://localhost:9000
MATHEMATICA_HOME ?=

# Wolfram script command - use from MATHEMATICA_HOME if set, otherwise search PATH
ifdef MATHEMATICA_HOME
	WOLFRAMSCRIPT := $(MATHEMATICA_HOME)/wolframscript
else
	WOLFRAMSCRIPT := wolframscript
endif

#help: Show this help message
help:
	@echo "========================================="
	@echo "  Mathematica SonarQube Test Project"
	@echo "========================================="
	@echo ""
	@echo "Available targets:"
	@echo ""
	@echo "  make help     - Show this help message"
	@echo "  make test     - Run Wolfram unit tests with coverage"
	@echo "  make scan     - Run SonarQube code analysis"
	@echo "  make run      - Run the Mathematica demo program"
	@echo "  make clean    - Clean generated files"
	@echo ""
	@echo "Environment variables:"
	@echo "  MATHEMATICA_HOME - Path to Mathematica installation (current: $(if $(MATHEMATICA_HOME),$(MATHEMATICA_HOME),<not set>))"
	@echo "  SONARQUBE_HOME   - Path to SonarQube installation (current: $(SONARQUBE_HOME))"
	@echo "  SONAR_TOKEN      - SonarQube authentication token"
	@echo "  SONAR_HOST_URL   - SonarQube server URL (current: $(SONAR_HOST_URL))"
	@echo ""
	@echo "Example usage:"
	@echo "  make test"
	@echo "  MATHEMATICA_HOME=/Applications/Mathematica.app/Contents make run"
	@echo "  SONAR_TOKEN=sqp_xxx make scan"
	@echo ""

#test: Run Wolfram unit tests with native coverage generation
test:
	@echo "Running Wolfram unit tests..."
	@echo ""
	@# Check if wolframscript is available
	@if ! command -v "$(WOLFRAMSCRIPT)" > /dev/null 2>&1 && ! [ -x "$(WOLFRAMSCRIPT)" ]; then \
		echo "ERROR: wolframscript not found!"; \
		echo ""; \
		echo "Please set MATHEMATICA_HOME to your Mathematica installation."; \
		echo "Example paths:"; \
		echo "  macOS:   /Applications/Mathematica.app/Contents"; \
		echo "  Linux:   /usr/local/Wolfram/Mathematica/13.0"; \
		echo "  Windows: C:/Program Files/Wolfram Research/Mathematica/13.0"; \
		echo ""; \
		echo "Then run: MATHEMATICA_HOME=/path/to/mathematica make test"; \
		exit 1; \
	fi
	@if [ ! -f RunTests.wl ]; then \
		echo "ERROR: RunTests.wl not found!"; \
		exit 1; \
	fi
	@"$(WOLFRAMSCRIPT)" -file RunTests.wl 2>/dev/null
	@echo ""
	@echo "Test run complete. Coverage data in ./coverage/"
	@echo ""

#scan: Run SonarQube code analysis
scan:
	@echo "========================================="
	@echo "  Running SonarQube Scan"
	@echo "========================================="
	@echo ""
	@# Check if SONARQUBE_HOME is set
	@if [ -z "$(SONARQUBE_HOME)" ]; then \
		echo "ERROR: SONARQUBE_HOME environment variable not set!"; \
		echo "Please set it to your SonarQube installation directory."; \
		echo "Example: export SONARQUBE_HOME=/usr/local/sonarqube"; \
		exit 1; \
	fi
	@# Check if sonar-scanner is available
	@if ! command -v sonar-scanner > /dev/null 2>&1; then \
		echo "ERROR: sonar-scanner not found in PATH!"; \
		echo "Please install sonar-scanner or add it to your PATH."; \
		echo "You can find it in: $(SONARQUBE_HOME)/bin/"; \
		exit 1; \
	fi
	@# Check if sonar-project.properties exists
	@if [ ! -f sonar-project.properties ]; then \
		echo "ERROR: sonar-project.properties not found!"; \
		exit 1; \
	fi
	@echo "SonarQube Home: $(SONARQUBE_HOME)"
	@echo "SonarQube URL: $(SONAR_HOST_URL)"
	@echo "Project config: sonar-project.properties"
	@echo ""
	@# Run sonar-scanner
	@if [ -n "$(SONAR_TOKEN)" ]; then \
		echo "Running scan with authentication..."; \
		sonar-scanner \
			-Dsonar.host.url=$(SONAR_HOST_URL) \
			-Dsonar.token=$(SONAR_TOKEN); \
	else \
		echo "WARNING: SONAR_TOKEN not set. Running without authentication."; \
		echo "If scan fails, set SONAR_TOKEN environment variable."; \
		echo ""; \
		sonar-scanner \
			-Dsonar.host.url=$(SONAR_HOST_URL); \
	fi
	@echo ""
	@echo "========================================="
	@echo "  Scan Complete"
	@echo "========================================="
	@echo ""
	@echo "View results at: $(SONAR_HOST_URL)"
	@echo ""

#run: Run the Mathematica demo program
run:
	@echo "========================================="
	@echo "  Running Mathematica Demo"
	@echo "========================================="
	@echo ""
	@# Check if wolframscript is available
	@if ! command -v "$(WOLFRAMSCRIPT)" > /dev/null 2>&1 && ! [ -x "$(WOLFRAMSCRIPT)" ]; then \
		echo "ERROR: wolframscript not found!"; \
		echo ""; \
		echo "Please set MATHEMATICA_HOME to your Mathematica installation."; \
		echo "Example paths:"; \
		echo "  macOS:   /Applications/Mathematica.app/Contents"; \
		echo "  Linux:   /usr/local/Wolfram/Mathematica/13.0"; \
		echo "  Windows: C:/Program Files/Wolfram Research/Mathematica/13.0"; \
		echo ""; \
		echo "Then run: MATHEMATICA_HOME=/path/to/mathematica make run"; \
		exit 1; \
	fi
	@echo "Loading Calculator module..."
	@"$(WOLFRAMSCRIPT)" -code ' \
		Off[LibraryFunctionLoad::strfile]; \
		Off[General::shdw]; \
		Quiet[Get["src/Calculator.wl"]]; \
		Print["Calculator module loaded."]; \
		Print[""]; \
		Print["Examples:"]; \
		Print["  Add[5, 3] = ", Calculator`Add[5, 3]]; \
		Print["  Subtract[10, 4] = ", Calculator`Subtract[10, 4]]; \
		Print["  Multiply[6, 7] = ", Calculator`Multiply[6, 7]]; \
		Print["  Divide[20, 4] = ", Calculator`Divide[20, 4]]; \
		Print[""]; \
		Print["Loading StringUtils module..."]; \
		Quiet[Get["src/StringUtils.wl"]]; \
		Print["StringUtils module loaded."]; \
		Print[""]; \
		Print["More examples:"]; \
		Print["  ReverseString[\"hello\"] = ", StringUtils`ReverseString["hello"]]; \
		Print["  Square[8] = ", StringUtils`Square[8]]; \
		Print["  Fibonacci[6] = ", StringUtils`Fibonacci[6]]; \
		Print[""]; \
		Print["Demo complete!"]; \
		""; \
	' 2>/dev/null | grep -v "^Null$$"
	@echo ""

#clean: Clean generated files
clean:
	@echo "Cleaning generated files..."
	@rm -rf coverage/
	@rm -rf .scannerwork/
	@rm -f *.log
	@echo "Clean complete."
	@echo ""
