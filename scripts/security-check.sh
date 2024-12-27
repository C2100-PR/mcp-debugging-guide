#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=== Security Check Script ==="

# Check for potential secrets
check_secrets() {
    echo "Checking for potential secrets..."
    patterns=(
        "api[_-]key"
        "auth[_-]token"
        "password"
        "secret"
        "credentials"
        "private[_-]key"
    )

    for pattern in "${patterns[@]}"; do
        results=$(git grep -i "$pattern" -- ':!scripts/security-check.sh' ':!.gitignore' || true)
        if [ ! -z "$results" ]; then
            echo -e "${RED}WARNING: Potential secret pattern found: $pattern${NC}"
            echo "$results"
        fi
    done
}

# Check for sensitive files
check_sensitive_files() {
    echo "\nChecking for sensitive files..."
    sensitive_files=(
        "*.pem"
        "*.key"
        "*.p12"
        "*.pfx"
        "id_rsa"
        "id_dsa"
        "*.keystore"
        "service-account*.json"
    )

    for pattern in "${sensitive_files[@]}"; do
        if find . -name "$pattern" -not -path "./node_modules/*" 2>/dev/null | grep -q .; then
            echo -e "${RED}WARNING: Sensitive file pattern found: $pattern${NC}"
            find . -name "$pattern" -not -path "./node_modules/*"
        fi
    done
}

# Check environment variables
check_env_vars() {
    echo "\nChecking environment variables..."
    if [ -f ".env" ]; then
        echo -e "${YELLOW}WARNING: .env file found. Ensure it is in .gitignore${NC}"
    fi
}

# Run all checks
check_secrets
check_sensitive_files
check_env_vars

echo -e "\n${GREEN}Security check complete${NC}"
