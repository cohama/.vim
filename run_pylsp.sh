#!/bin/bash -eu
python_paths=$(python -c "import sys; print(sys.path[-1])")
python_version=$(python -c "import sys; print(*sys.version_info[:2], sep='.')")
exec env "PYTHONPATH=${python_paths}:.venv/lib/python${python_version}/site-packages" pylsp
