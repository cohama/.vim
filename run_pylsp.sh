#!/bin/bash -eu
if [[ -x $(command -v rye) && -x $(command -v rye) ]] ; then
  python_cmd="$HOME/.rye/shims/python"
elif [[ -x $(command -v pipx) && -x $(command -v pylsp) ]] ; then
  python_cmd=$(pipx environment -v PIPX_LOCAL_VENVS)/python-lsp-server/bin/python
else
  python_cmd=python
fi
python_paths=$("$python_cmd" -c "import sys; print(':'.join(sys.path[-2:]))")
python_version=$("$python_cmd" -c "import sys; print(*sys.version_info[:2], sep='.')")
cache_dir=${XDG_CACHE_HOME:-"$HOME/.cache"}/nvim/pylsp
mkdir -p "$cache_dir"
echo python_paths="$python_paths" >&2
exec env "PYTHONPATH=${python_paths}:.venv/lib/python${python_version}/site-packages" pylsp -vv --log-file "$cache_dir/lsp.log"
