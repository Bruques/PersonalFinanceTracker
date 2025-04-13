.PHONY: setup check-brew check-xcodegen check-cocoapods install-brew install-xcodegen install-cocoapods generate setup-env list-teams

# Default target
setup: check-brew check-xcodegen check-cocoapods

# Check if Homebrew is installed
check-brew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Homebrew not found. Installing...⏳"; \
		$(MAKE) install-brew; \
	else \
		echo "✅ Homebrew is already installed."; \
	fi

# Install Homebrew (macOS only)
install-brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo 'export PATH="/usr/local/bin:/opt/homebrew/bin:$$PATH"' >> ~/.zshrc  # For M1/M2 and macOS
	@source ~/.zshrc  # Reload shell (may not work in Makefile; user might need to restart terminal)

# Check if XcodeGen is installed
check-xcodegen:
	@if ! command -v xcodegen >/dev/null 2>&1; then \
		echo "XcodeGen not found. Installing...⏳"; \
		$(MAKE) install-xcodegen; \
	else \
		echo "✅ XcodeGen is already installed."; \
	fi

# Install XcodeGen via Homebrew
install-xcodegen:
	brew install xcodegen

# Check if Cocoapods is installed
check-cocoapods:
	@if ! command -v pod >/dev/null 2>&1; then \
		echo "cocoapods not found. Installing... ⏳"; \
		$(MAKE) install-cocoapods; \
	else \
		echo "✅ Cocoapods is already installed."; \
	fi

# Install Cocoapods
install-cocoapods:
	@if command -v brew >/dev/null 2>&1; then \
		brew install cocoapods; \
	else \
		echo "Homebrew not available. Run install-brew"; \
	fi

setup-env:
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "✅ Created .env. Edit it now!"; \
	else \
		echo "✅ .env is already defined"; \
	fi

list-teams:
	@if ! command -v python3 &> /dev/null; then \
		echo "python3 not found. Installing... ⏳"; \
		brew install python3; \
	else \
		echo "✅ python3 is already installed."; \
	fi
	@python3 extract_teams.py

# Generate the project
generate: setup-env
	@source .env && \
	echo "Bundle prefix: $$BUNDLE_PREFIX" && \
	echo "Development team: $$MY_DEVELOPMENT_TEAM" && \
	export BUNDLE_PREFIX=$$BUNDLE_PREFIX && \
	export MY_DEVELOPMENT_TEAM=$$MY_DEVELOPMENT_TEAM && \
	xcodegen generate --spec project.yml