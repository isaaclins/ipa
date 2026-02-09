#!/bin/bash
# ============================================================================
# IPA Documentation Framework - Build Script
# ============================================================================
# This script builds the Hugo site for deployment.
#
# For PDF generation:
# 1. Run `hugo server` or deploy the site
# 2. Open /pdf/ in your browser
# 3. Click "Als PDF speichern" or use Ctrl+P / Cmd+P
# 4. Select "Save as PDF" in the print dialog
#
# Requirements:
# - Hugo Extended (https://gohugo.io/)
#
# Usage:
#   ./scripts/build.sh         # Full build
#   ./scripts/build.sh serve   # Development server
#   ./scripts/build.sh clean   # Clean build artifacts
# ============================================================================

set -e  # Exit on error

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="${PROJECT_ROOT}/public"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check required dependencies
check_dependencies() {
    log_info "Checking dependencies..."
    
    if ! command_exists hugo; then
        log_error "Hugo is not installed. Please install Hugo Extended."
        log_info "  macOS: brew install hugo"
        log_info "  Linux: snap install hugo --channel=extended"
        exit 1
    fi
    
    log_success "Hugo found: $(hugo version | head -n1)"
}

# Clean build artifacts
clean() {
    log_info "Cleaning build artifacts..."
    rm -rf "${OUTPUT_DIR}"
    log_success "Clean complete."
}

# Build HTML with Hugo
build_html() {
    log_info "Building Hugo site..."
    cd "${PROJECT_ROOT}"
    
    # Run Hugo build
    hugo --minify --gc
    
    if [ -d "${OUTPUT_DIR}" ]; then
        log_success "HTML build complete: ${OUTPUT_DIR}"
    else
        log_error "Hugo build failed - output directory not created."
        exit 1
    fi
}

# Development server
serve() {
    log_info "Starting Hugo development server..."
    cd "${PROJECT_ROOT}"
    hugo server --buildDrafts --buildFuture --navigateToChanged
}

# Full build
build_all() {
    check_dependencies
    clean
    build_html
    
    echo ""
    log_success "============================================"
    log_success "Build complete!"
    log_success "============================================"
    log_info "HTML output: ${OUTPUT_DIR}"
    echo ""
    log_info "To generate PDF:"
    log_info "  1. Open ${OUTPUT_DIR}/pdf/index.html in a browser"
    log_info "  2. Wait for diagrams to render"
    log_info "  3. Click 'Als PDF speichern' or press Ctrl+P / Cmd+P"
    log_info "  4. Select 'Save as PDF' in the print dialog"
}

# Main script
main() {
    case "${1:-all}" in
        html|build)
            check_dependencies
            build_html
            ;;
        clean)
            clean
            ;;
        serve|dev)
            serve
            ;;
        all|"")
            build_all
            ;;
        *)
            echo "Usage: $0 {build|clean|serve|all}"
            echo ""
            echo "Commands:"
            echo "  build/html  Build the Hugo site"
            echo "  clean       Remove build artifacts"
            echo "  serve/dev   Start development server"
            echo "  all         Clean and build (default)"
            exit 1
            ;;
    esac
}

main "$@"
