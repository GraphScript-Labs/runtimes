#!/bin/bash

# Get absolute path of the current directory
VENV_DIR="./runtime"
NEW_VENV_PATH="$(cd "$VENV_DIR" && pwd)"
PYTHON_BIN="$NEW_VENV_PATH/bin/python3"

echo "🔧 Updating venv paths to: $NEW_VENV_PATH"

# 1. Patch pyvenv.cfg
if [ -f "$VENV_DIR/pyvenv.cfg" ]; then
  echo "✅ Patching pyvenv.cfg"
  sed -i '' "s|^home = .*|home = $NEW_VENV_PATH/bin/python3|" "$VENV_DIR/pyvenv.cfg"
fi

# 2. Patch activate scripts
for f in "$VENV_DIR"/bin/activate*; do
  if [[ -f "$f" ]]; then
    echo "✅ Patching $f"
    sed -i '' "s|^VIRTUAL_ENV=.*|VIRTUAL_ENV=\"$NEW_VENV_PATH\"|" "$f"
  fi
done

# 3. Patch shebangs in bin scripts (e.g., pip, flask)
echo "✅ Patching shebangs in venv/bin/*"
for f in "$VENV_DIR"/bin/*; do
  if head -1 "$f" | grep -q "^#\!.*python"; then
    sed -i '' "1 s|^#!.*python.*|#!$PYTHON_BIN|" "$f"
  fi
done

# 4. Optional: clean .pyc files (they sometimes cache paths)
echo "🧹 Deleting stale .pyc files"
find "$VENV_DIR" -name "*.pyc" -delete

echo "🎉 Done. Your venv is now patched for: $NEW_VENV_PATH"