#!/bin/sh
# Atelier: instalador y actualizador para Linux (cualquier distribución x86_64).
#
#   Instalar o actualizar:
#     curl -fsSL https://raw.githubusercontent.com/Amariless/Atelier-releases/main/install.sh | sh
#   Desinstalar (los datos de la app se conservan):
#     curl -fsSL https://raw.githubusercontent.com/Amariless/Atelier-releases/main/install.sh | sh -s -- --uninstall
#
# No pide permisos de administrador: todo queda en la carpeta del usuario.
# Variables opcionales: ATELIER_FORCE=1 reinstala aunque la versión sea la misma.
set -eu

REPO="Amariless/Atelier-releases"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
APP_DIR="$DATA/atelier"
APPIMAGE="$APP_DIR/Atelier.AppImage"
BIN_DIR="$HOME/.local/bin"
LAUNCHER="$BIN_DIR/atelier"
DESKTOP="$DATA/applications/atelier.desktop"
ICON="$DATA/icons/hicolor/128x128/apps/atelier.png"

say() { printf '%s\n' "$*"; }
die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

if [ "${1:-}" = "--uninstall" ]; then
  rm -f "$APPIMAGE" "$APP_DIR/version" "$LAUNCHER" "$DESKTOP" "$ICON"
  rmdir "$APP_DIR" 2>/dev/null || true
  command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$DATA/applications" >/dev/null 2>&1 || true
  say "Atelier se desinstaló. Tus datos no se tocaron."
  exit 0
fi

case "$(uname -s)" in
  Linux) ;;
  Darwin) die "Atelier todavía no tiene versión para macOS." ;;
  *) die "Sistema no compatible. En Windows usa install.ps1." ;;
esac
case "$(uname -m)" in
  x86_64|amd64) ;;
  *) die "Solo hay versión para x86_64 (este equipo es $(uname -m))." ;;
esac

if command -v curl >/dev/null 2>&1; then
  fetch() { curl -fsSL "$1"; }
  download() { curl -fL --progress-bar -o "$2" "$1"; }
elif command -v wget >/dev/null 2>&1; then
  fetch() { wget -qO- "$1"; }
  download() { wget -q --show-progress -O "$2" "$1"; }
else
  die "Hace falta curl o wget."
fi
command -v sha256sum >/dev/null 2>&1 || die "Hace falta sha256sum (paquete coreutils)."

say "Buscando la última versión..."
MANIFEST="$(fetch "https://github.com/$REPO/releases/latest/download/latest.json")" || die "No se pudo leer la última versión. Revisa tu conexión."
VERSION="$(printf '%s\n' "$MANIFEST" | sed -n 's/^[[:space:]]*"version":[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"
URL="$(printf '%s\n' "$MANIFEST" | awk '/"linux-x86_64"/{f=1} f&&/"url"/{print; exit}' | sed -n 's/.*"url":[[:space:]]*"\([^"]*\)".*/\1/p')"
[ -n "$VERSION" ] && [ -n "$URL" ] || die "La información de la versión no tiene el formato esperado."

if [ -f "$APPIMAGE" ] && [ "$(cat "$APP_DIR/version" 2>/dev/null || true)" = "$VERSION" ] && [ "${ATELIER_FORCE:-0}" != "1" ]; then
  say "Atelier $VERSION ya está instalada y al día."
  exit 0
fi

mkdir -p "$APP_DIR" "$BIN_DIR" "$DATA/applications" "$(dirname "$ICON")"
PART="$APP_DIR/.Atelier.AppImage.part"
trap 'rm -f "$PART"' EXIT

say "Descargando Atelier $VERSION..."
download "$URL" "$PART" || die "Falló la descarga."

# Verificación con la suma publicada junto a la versión. Las versiones
# anteriores a la 0.2.0 no la traen: se avisa y se sigue.
NAME="${URL##*/}"
if SUMS="$(fetch "${URL%/*}/SHA256SUMS" 2>/dev/null)"; then
  WANT="$(printf '%s\n' "$SUMS" | awk -v n="$NAME" '$2==n{print $1; exit}')"
  [ -n "$WANT" ] || die "SHA256SUMS no incluye $NAME."
  HAVE="$(sha256sum "$PART" | awk '{print $1}')"
  [ "$WANT" = "$HAVE" ] || die "La suma de verificación no coincide. No se instaló nada."
  say "Verificación correcta."
else
  say "Aviso: esta versión no publica sumas de verificación, se instala sin verificar."
fi

chmod +x "$PART"
mv -f "$PART" "$APPIMAGE"
printf '%s\n' "$VERSION" > "$APP_DIR/version"

# Los AppImage necesitan libfuse2. Si no está, el lanzador usa el modo que
# extrae a una carpeta temporal (arranca más lento, pero funciona).
cat > "$LAUNCHER" <<LAUNCH
#!/bin/sh
if ! { /sbin/ldconfig -p 2>/dev/null || ldconfig -p 2>/dev/null; } | grep -q 'libfuse\.so\.2'; then
  export APPIMAGE_EXTRACT_AND_RUN=1
fi
exec "$APPIMAGE" "\$@"
LAUNCH
chmod +x "$LAUNCHER"

fetch "https://raw.githubusercontent.com/$REPO/main/atelier.png" > "$ICON" 2>/dev/null || rm -f "$ICON"
cat > "$DESKTOP" <<ENTRY
[Desktop Entry]
Type=Application
Name=Atelier
Comment=Herramientas de escritorio
Exec=$LAUNCHER
Icon=atelier
Terminal=false
Categories=Utility;
StartupWMClass=atelier
ENTRY
command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$DATA/applications" >/dev/null 2>&1 || true

say ""
say "Atelier $VERSION quedó instalada."
if pgrep -x atelier >/dev/null 2>&1 || pgrep -f "Atelier.AppImage" >/dev/null 2>&1; then
  say "Atelier está abierta: ciérrala y ábrela de nuevo para usar la versión nueva."
fi
say "Ábrela desde el menú de aplicaciones o con el comando: atelier"
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) say "Aviso: $BIN_DIR no está en tu PATH. Agrégalo para poder escribir 'atelier' en la terminal." ;;
esac
if ! { /sbin/ldconfig -p 2>/dev/null || ldconfig -p 2>/dev/null; } | grep -q 'libfuse\.so\.2'; then
  . /etc/os-release 2>/dev/null || true
  case "${ID:-} ${ID_LIKE:-}" in
    *arch*) HINT="sudo pacman -S fuse2" ;;
    *fedora*|*rhel*) HINT="sudo dnf install fuse-libs" ;;
    *suse*) HINT="sudo zypper install libfuse2" ;;
    *ubuntu*|*debian*) HINT="sudo apt install libfuse2 (en Ubuntu 24.04: libfuse2t64)" ;;
    *) HINT="instala el paquete libfuse2 de tu distribución" ;;
  esac
  say "Nota: no se encontró libfuse2. Funciona igual, pero abre más lento. Para arreglarlo: $HINT"
fi
