#!/bin/bash

# YAML Validation Script for CKAD Questions Repository
# This script validates all YAML files in the repository for syntax errors

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
total_files=0
valid_files=0
invalid_files=0

echo "🔍 CKAD Repository YAML Validation"
echo "=================================="

# Function to validate a single YAML file
validate_yaml_file() {
    local file="$1"
    local filename=$(basename "$file")
    
    echo -n "Validating $filename... "
    
    if kubectl apply --dry-run=client -f "$file" &>/dev/null; then
        echo -e "${GREEN}✓ Valid${NC}"
        ((valid_files++))
        return 0
    else
        echo -e "${RED}✗ Invalid${NC}"
        echo -e "${RED}Error details:${NC}"
        kubectl apply --dry-run=client -f "$file" 2>&1 | sed 's/^/  /'
        ((invalid_files++))
        return 1
    fi
}

# Function to validate YAML files in a directory
validate_directory() {
    local dir="$1"
    local dir_name=$(basename "$dir")
    
    if [ ! -d "$dir" ]; then
        echo -e "${YELLOW}⚠ Directory not found: $dir${NC}"
        return 0
    fi
    
    echo ""
    echo "📁 Checking directory: $dir_name"
    echo "$(printf '%.0s-' {1..50})"
    
    local found_yaml=false
    
    # Find all YAML files in the directory
    while IFS= read -r -d '' file; do
        found_yaml=true
        ((total_files++))
        validate_yaml_file "$file"
    done < <(find "$dir" -name "*.yaml" -o -name "*.yml" -print0)
    
    if [ "$found_yaml" = false ]; then
        echo -e "${YELLOW}ℹ No YAML files found in $dir_name${NC}"
    fi
}

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo -e "${RED}Error: kubectl is not installed or not in PATH${NC}"
    echo "Please install kubectl to run YAML validation"
    exit 1
fi

# Get target directory from argument or use current directory
target_dir="${1:-.}"

if [ "$target_dir" = "." ]; then
    echo "📂 Validating all YAML files in repository..."
    
    # Validate specific directories
    validate_directory "questions"
    validate_directory "solutions"
    validate_directory "examples"
    validate_directory "templates"
    
    # Check for any other YAML files in root
    echo ""
    echo "📁 Checking root directory"
    echo "$(printf '%.0s-' {1..50})"
    
    for file in *.yaml *.yml; do
        if [ -f "$file" ]; then
            ((total_files++))
            validate_yaml_file "$file"
        fi
    done
    
else
    echo "📂 Validating YAML files in: $target_dir"
    validate_directory "$target_dir"
fi

# Summary
echo ""
echo "📊 Validation Summary"
echo "===================="
echo -e "Total files checked: $total_files"
echo -e "${GREEN}Valid files: $valid_files${NC}"
echo -e "${RED}Invalid files: $invalid_files${NC}"

if [ $invalid_files -eq 0 ]; then
    echo -e "${GREEN}🎉 All YAML files are valid!${NC}"
    exit 0
else
    echo -e "${RED}❌ Found $invalid_files invalid YAML file(s)${NC}"
    echo "Please fix the errors above before committing."
    exit 1
fi