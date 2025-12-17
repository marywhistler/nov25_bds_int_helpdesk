#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="helpdesk"
MINIFORGE_DIR="$HOME/miniforge3"

echo "==> 1) System basics"
sudo apt-get update -y
sudo apt-get install -y git curl unzip

echo "==> 2) Install Miniforge (Conda) if missing"
if [ ! -d "$MINIFORGE_DIR" ]; then
  curl -L -o /tmp/Miniforge3.sh \
    https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
  bash /tmp/Miniforge3.sh -b -p "$MINIFORGE_DIR"
fi

echo "==> 3) Activate conda"
source "$MINIFORGE_DIR/etc/profile.d/conda.sh"

echo "==> 4) Create/Update environment"
conda env update -n "$ENV_NAME" -f environment.yml --prune || conda env create -f environment.yml

echo "==> 5) Register Jupyter kernel for VS Code"
conda activate "$ENV_NAME"
python -m ipykernel install --user --name "$ENV_NAME" --display-name "Python ($ENV_NAME)"

echo "==> DONE ✅"
