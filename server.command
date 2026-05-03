#!/usr/bin/env bash
# f.command — double-click on Mac to launch AI Console locally.
# Mac equivalent of a .bat file.

cd "$(dirname "$0")"
PORT=8000
URL="http://localhost:$PORT/ai-console.html"

clear
cat <<'BANNER'

   █████╗ ██╗    ██████╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ██╗     ███████╗
  ██╔══██╗██║   ██╔════╝██╔═══██╗████╗  ██║██╔════╝██╔═══██╗██║     ██╔════╝
  ███████║██║   ██║     ██║   ██║██╔██╗ ██║███████╗██║   ██║██║     █████╗
  ██╔══██║██║   ██║     ██║   ██║██║╚██╗██║╚════██║██║   ██║██║     ██╔══╝
  ██║  ██║██║██╗╚██████╗╚██████╔╝██║ ╚████║███████║╚██████╔╝███████╗███████╗
  ╚═╝  ╚═╝╚═╝╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝

BANNER

echo "  Starting local server on port $PORT…"
echo "  URL: $URL"
echo ""
echo "  Press Ctrl+C in this window to stop the server."
echo "  Close this window when you're done."
echo ""
echo "  ──────────────────────────────────────────────────"
echo ""

# Open browser after a short delay so the server is ready
( sleep 1.5 && open "$URL" ) &

# Pick the best available server
if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server $PORT
elif command -v python >/dev/null 2>&1; then
  python -m http.server $PORT 2>/dev/null || python -m SimpleHTTPServer $PORT
elif command -v npx >/dev/null 2>&1; then
  npx --yes serve . -l $PORT
elif command -v ruby >/dev/null 2>&1; then
  ruby -run -e httpd . -p $PORT
else
  echo ""
  echo "  ✗ No server found. Install Python from https://python.org"
  echo "    or Node.js from https://nodejs.org and try again."
  echo ""
  echo "  Press any key to close…"
  read -n 1
  exit 1
fi
