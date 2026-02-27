#!/usr/bin/env bash
set -euo pipefail

# 1) Sync static assets from site/web -> docs (what GitHub Pages serves)
mkdir -p docs
rm -rf docs/images
mkdir -p docs/images

cp site/web/styles.css docs/styles.css
cp -r site/web/images/* docs/images/

# Keep index.html as-is (you maintain it in docs/)
# 2) Build client JS -> docs/main.dart.js
cd site
dart pub get
dart compile js -O4 --no-source-maps lib/main.client.dart -o ../docs/main.dart.js
cd ..

echo "OK: Built docs/ (styles, images, main.dart.js)"
