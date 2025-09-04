#!/usr/bin/env bash
#
# translate_xlibre.sh — Batch V translation of XLibre Xserver C sources
#
# Usage: ./translate_xlibre.sh /path/to/v /path/to/xlibre /path/to/output [builddir]
#
set -uo pipefail
V_BIN="${1:-}"
SRC_ROOT="${2:-}"
OUT_ROOT="${3:-}"
BUILDDIR="${4:-$SRC_ROOT/builddir}"
if [[ -z "$V_BIN" || -z "$SRC_ROOT" || -z "$OUT_ROOT" ]]; then
    echo "Usage: $0 /path/to/v /path/to/xlibre /path/to/output [builddir]"
    exit 1
fi
if [[ ! -x "$V_BIN" ]]; then
    echo "Error: V binary not found or not executable at $V_BIN"
    exit 1
fi
# Normalize paths
SRC_ROOT="$(realpath "$SRC_ROOT")"
OUT_ROOT="$(realpath -m "$OUT_ROOT")"
BUILDDIR="$(realpath -m "$BUILDDIR")"
mkdir -p "$OUT_ROOT"
echo "=== XLibre to V Translation Setup ==="
echo "V Binary: $V_BIN"
echo "Source Root: $SRC_ROOT"
echo "Output Root: $OUT_ROOT"
echo "Build Directory: $BUILDDIR"
# Function to find dix-config.h
find_dix_config() {
    local search_paths=(
        "$BUILDDIR/include"
        "$BUILDDIR"
        "$SRC_ROOT/include"
        "$SRC_ROOT"
    )
    for path in "${search_paths[@]}"; do
        if [[ -f "$path/dix-config.h" ]]; then
            echo "$path/dix-config.h"
            return 0
        fi
    done
    return 1
}
DIX_CONFIG_H="$(find_dix_config 2>/dev/null || true)"
if [[ -z "$DIX_CONFIG_H" ]]; then
    echo "Warning: dix-config.h not found in standard locations."
    echo "You may need to run 'meson setup builddir' or './configure' first."
    echo "Attempting translation with a temporary config..."
fi
# Build comprehensive include paths
build_include_paths() {
    local includes=()
    # Core source directories
    includes+=("-I$SRC_ROOT")
    includes+=("-I$SRC_ROOT/include")
    includes+=("-I$SRC_ROOT/dix")
    includes+=("-I$SRC_ROOT/hw")
    includes+=("-I$SRC_ROOT/hw/xfree86/common")
    includes+=("-I$SRC_ROOT/hw/xfree86/os-support")
    includes+=("-I$SRC_ROOT/hw/xfree86/os-support/linux")
    includes+=("-I$SRC_ROOT/hw/xnest")
    includes+=("-I$SRC_ROOT/hw/vfb")
    includes+=("-I$SRC_ROOT/os")
    includes+=("-I$SRC_ROOT/render")
    includes+=("-I$SRC_ROOT/randr")
    includes+=("-I$SRC_ROOT/xkb")
    includes+=("-I$SRC_ROOT/Xi")
    includes+=("-I$SRC_ROOT/xfixes")
    includes+=("-I$SRC_ROOT/composite")
    includes+=("-I$SRC_ROOT/damageext")
    includes+=("-I$SRC_ROOT/fb")
    includes+=("-I$SRC_ROOT/mi")
    includes+=("-I$SRC_ROOT/miext/damage")
    includes+=("-I$SRC_ROOT/miext/shadow")
    includes+=("-I$SRC_ROOT/miext/sync")
    includes+=("-I$SRC_ROOT/Xext")
    includes+=("-I$SRC_ROOT/record")
    includes+=("-I$SRC_ROOT/xtest")
    includes+=("-I$SRC_ROOT/present")
    includes+=("-I$SRC_ROOT/glamor")
    # Build directory (for generated headers)
    if [[ -d "$BUILDDIR" ]]; then
        includes+=("-I$BUILDDIR")
        includes+=("-I$BUILDDIR/include")
        includes+=("-I$BUILDDIR/dix")
    fi
    # System includes via pkg-config
    if command -v pkg-config >/dev/null 2>&1; then
        local pkg_cflags
        for pkg in x11 xproto renderproto xextproto damageproto randrproto presentproto dri3proto xf86driproto; do
            if pkg_cflags=$(pkg-config --cflags-only-I "$pkg" 2>/dev/null); then
                includes+=($pkg_cflags)
            fi
        done
        if pkg_cflags=$(pkg-config --cflags-only-I pixman-1 2>/dev/null); then
            includes+=($pkg_cflags)
        fi
    fi
    # Common system include paths
    includes+=("-I/usr/include/X11")
    includes+=("-I/usr/include/pixman-1")
    includes+=("-I/usr/include/drm")
    # Remove duplicates and return
    printf '%s\n' "${includes[@]}" | sort -u
}
# Build preprocessor definitions
build_defines() {
    local defines=()
    # Common X server defines
    defines+=("-DHAVE_DIX_CONFIG_H")
    defines+=("-DXORG_VERSION_CURRENT=0")
    defines+=("-D_GNU_SOURCE")
    defines+=("-DHAS_FCHOWN")
    defines+=("-DHAS_STICKY_DIR_BIT")
    defines+=("-DIPv6")
    defines+=("-DTCPCONN")
    defines+=("-DUNIXCONN")
    defines+=("-DHAS_SHM")
    defines+=("-DDDXBEFORERESET")
    defines+=("-DUSE_RGB_TXT")
    defines+=("-DMITSHM")
    # Platform specific
    case "$(uname -s)" in
        Linux)
            defines+=("-D__linux__")
            defines+=("-DLINUX")
            ;;
        Darwin)
            defines+=("-D__APPLE__")
            ;;
        FreeBSD|OpenBSD|NetBSD)
            defines+=("-D__BSD__")
            ;;
    esac
    printf '%s\n' "${defines[@]}"
}
# Get all include paths and defines
echo "Building include paths and preprocessor definitions..."
mapfile -t INCLUDE_PATHS < <(build_include_paths)
mapfile -t DEFINES < <(build_defines)
echo "Include paths: ${#INCLUDE_PATHS[@]} found"
echo "Preprocessor definitions: ${#DEFINES[@]} found"
# Combine all compiler flags
CFLAGS=("${INCLUDE_PATHS[@]}" "${DEFINES[@]}")
# Create a temporary config header if dix-config.h is missing
create_temp_config() {
    local config_file="$OUT_ROOT/temp-dix-config.h"
    if [[ -z "$DIX_CONFIG_H" ]]; then
        echo "Creating temporary dix-config.h..."
        cat > "$config_file" << 'EOF'
#ifndef DIX_CONFIG_H
#define DIX_CONFIG_H
/* Minimal config for translation */
#define PACKAGE_NAME "xorg-server"
#define PACKAGE_VERSION "21.1.0"
#define HAVE_STRLCPY 1
#define HAVE_STRLCAT 1
#define HAVE_STRCASECMP 1
#define HAVE_STRCASESTR 1
#define HAVE_STRNDUP 1
#define HAVE_TIMINGSAFE_MEMCMP 1
#define HAVE_LIBBSD 1
#define USE_SHM 1
#define HAS_SHM 1
#define HAVE_XORG_CONFIG_H 1
#define HAVE_DIX_CONFIG_H 1
#endif /* DIX_CONFIG_H */
EOF
        CFLAGS+=("-I$OUT_ROOT")
        echo "Temporary config created at: $config_file"
    else
        CFLAGS+=("-I$(dirname "$DIX_CONFIG_H")")
        echo "Using dix-config.h from: $DIX_CONFIG_H"
    fi
}
create_temp_config
# Find all .c files under SRC_ROOT, relative paths only
echo "Scanning for C source files..."
mapfile -t c_files < <(find "$SRC_ROOT" -type f -name '*.c' -printf '%P\n' | grep -v -E '^(test/|tests/|builddir/)')
echo "Found ${#c_files[@]} C files to translate..."
# Statistics
SUCCESS_COUNT=0
FAILED_COUNT=0
ERROR_LOG="$OUT_ROOT/translation_errors.log"
> "$ERROR_LOG"
# Function to translate a single file
translate_file() {
    local rel_path="$1"
    local src_file="$SRC_ROOT/$rel_path"
    local out_path="$OUT_ROOT/${rel_path%.c}.v"
    local err_path="$out_path.err"
    mkdir -p "$(dirname "$out_path")"
    echo "[*] Translating $rel_path"
    echo "    Command: $V_BIN translate c $src_file -o $out_path ${CFLAGS[*]}"
    if "$V_BIN" translate c "$src_file" -o "$out_path" "${CFLAGS[@]}" 2> "$err_path"; then
        echo "    ✓ Success"
        rm -f "$err_path"
        return 0
    else
        echo "    ✗ Failed - see $err_path"
        {
            echo "=== TRANSLATION FAILURE ==="
            echo "File: $rel_path"
            echo "Command: $V_BIN translate c $src_file -o $out_path ${CFLAGS[*]}"
            echo "Error output:"
            cat "$err_path" 2>/dev/null || echo "No error output captured"
            echo "=== END FAILURE ==="
            echo ""
        } >> "$ERROR_LOG"
        return 1
    fi
}
# Process files with progress indication
echo ""
echo "Starting translation..."
for i in "${!c_files[@]}"; do
    rel_path="${c_files[$i]}"
    echo "[$((i+1))/${#c_files[@]}]"
    if translate_file "$rel_path"; then
        ((SUCCESS_COUNT++))
    else
        ((FAILED_COUNT++))
    fi
done
echo ""
echo "=== Translation Summary ==="
echo "Total files processed: ${#c_files[@]}"
echo "Successful translations: $SUCCESS_COUNT"
echo "Failed translations: $FAILED_COUNT"
echo "Success rate: $(( SUCCESS_COUNT * 100 / ${#c_files[@]} ))%"
if [[ $FAILED_COUNT -gt 0 ]]; then
    echo ""
    echo "❌ $FAILED_COUNT files failed to translate"
    echo "Check individual .err files in the output directory"
    echo "Summary of errors available in: $ERROR_LOG"
    echo ""
    echo "Common issues and solutions:"
    echo "  • Missing headers: Ensure you've run 'meson setup builddir' or './configure'"
    echo "  • Include path issues: Check that all required -I paths are present"
    echo "  • Unsupported C features: Some C constructs may not be translatable to V"
else
    echo "🎉 All files translated successfully!"
fi
echo ""
echo "Output directory: $OUT_ROOT"
echo "Done."
