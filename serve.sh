#!/usr/bin/env bash
# Serve this folder over http://localhost:8000
# Mac/Linux: double-click, or run `bash serve.sh` in terminal.
cd "$(dirname "$0")"
PORT=8000
echo ""
echo "  ┌────────────────────────────────────────────────┐"
echo "  │  AI Console — local server                     │"
echo "  │                                                │"
echo "  │  Open: http://localhost:$PORT/ai-console.html    │"
echo "  │                                                │"
echo "  │  Press Ctrl+C to stop.                         │"
echo "  └────────────────────────────────────────────────┘"
echo ""

# Try to open the browser automatically
URL="http://localhost:$PORT/ai-console.html"
( sleep 1.2
  if command -v open >/dev/null 2>&1;       then open "$URL"
  elif command -v xdg-open >/dev/null 2>&1; then xdg-open "$URL"
  fi ) &

# Prefer python3, fall back to python, then to npx
if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server $PORT
elif command -v python >/dev/null 2>&1; then
  python -m SimpleHTTPServer $PORT 2>/dev/null || python -m http.server $PORT
elif command -v npx >/dev/null 2>&1; then
  npx --yes serve . -l $PORT
else
  echo "Need python3 or npx. Install one and re-run." >&2
  exit 1
fi
