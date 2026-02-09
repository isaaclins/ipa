#!/bin/bash
# ============================================================================
# Mermaid Diagram Pre-render Script
# ============================================================================
# Pre-renders Mermaid diagrams to SVG/PNG for PDF compatibility.
#
# Requirements:
# - Node.js
# - mermaid-cli: npm install -g @mermaid-js/mermaid-cli
#
# Usage:
#   ./scripts/render-diagrams.sh
# ============================================================================

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONTENT_DIR="${PROJECT_ROOT}/content"
OUTPUT_DIR="${PROJECT_ROOT}/static/images/diagrams"
TEMP_DIR="${PROJECT_ROOT}/.diagrams-temp"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

# Check for mermaid-cli
if ! command -v mmdc &> /dev/null; then
    echo "mermaid-cli not found. Installing..."
    npm install -g @mermaid-js/mermaid-cli
fi

# Create output directory
mkdir -p "${OUTPUT_DIR}"
mkdir -p "${TEMP_DIR}"

log_info "Searching for Mermaid diagrams in content..."

# Counter for diagrams
DIAGRAM_COUNT=0

# Find all markdown files and extract Mermaid blocks
find "${CONTENT_DIR}" -name "*.md" -type f | while read -r file; do
    # Extract content between {{< diagram >}} and {{< /diagram >}}
    # This is a simplified approach
    
    # Check if file contains diagram shortcode
    if grep -q '{{< diagram' "$file"; then
        log_info "Found diagrams in: ${file#$CONTENT_DIR/}"
        
        # Extract diagram content using awk
        awk '
            /{{< diagram/{found=1; next}
            /{{< \/diagram >}}/{found=0; next}
            found{print}
        ' "$file" > "${TEMP_DIR}/diagram-${DIAGRAM_COUNT}.mmd"
        
        # Render if file has content
        if [ -s "${TEMP_DIR}/diagram-${DIAGRAM_COUNT}.mmd" ]; then
            mmdc -i "${TEMP_DIR}/diagram-${DIAGRAM_COUNT}.mmd" \
                 -o "${OUTPUT_DIR}/diagram-${DIAGRAM_COUNT}.svg" \
                 -b transparent \
                 --width 800
            
            log_success "Rendered: diagram-${DIAGRAM_COUNT}.svg"
            DIAGRAM_COUNT=$((DIAGRAM_COUNT + 1))
        fi
    fi
done

# Cleanup
rm -rf "${TEMP_DIR}"

log_success "Diagram pre-rendering complete. ${DIAGRAM_COUNT} diagrams processed."
