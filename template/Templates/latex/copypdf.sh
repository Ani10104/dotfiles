#!/bin/bash

# Config
SOURCE_DIR="Extra"
TARGET_DIR="Output"

# Verify directory structure
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Run this from 'myproj/' where '$SOURCE_DIR/' exists"
    exit 1
fi

# Create output directory
mkdir -p "$TARGET_DIR"

# Sync all PDFs (handles spaces/special chars)
find "$SOURCE_DIR" -maxdepth 1 -type f -name '*.pdf' -print0 | while IFS= read -r -d '' pdf; do
    filename=$(basename "$pdf")
    cp -fv "$pdf" "$TARGET_DIR/$filename"
done

# Success report
count=$(ls -1 "$TARGET_DIR"/*.pdf 2>/dev/null | wc -l)
echo "✅ Success: Copied $count PDF file(s) to $TARGET_DIR/"
