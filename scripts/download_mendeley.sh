#!/usr/bin/env bash
set -euo pipefail

mkdir -p data/raw

# Load MENDELEY_ZIP_URL from .env (local file, not committed)
if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

: "${MENDELEY_ZIP_URL:?Missing MENDELEY_ZIP_URL. Create .env from .env.example and paste the Mendeley Download-All link.}"

echo "==> Downloading dataset zip..."
curl -L "$MENDELEY_ZIP_URL" -o data/raw/mendeley_helpdesk.zip

echo "==> Unzipping..."
unzip -o data/raw/mendeley_helpdesk.zip -d data/raw/

echo "==> DONE ✅ Data is in data/raw/"
