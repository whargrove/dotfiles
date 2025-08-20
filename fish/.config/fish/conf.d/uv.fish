# uv setup
set -l uv_found 0

if command -q uv
    set uv_found 1
end

if test $uv_found -eq 0
    echo "uv not found. Please install it from https://docs.astral.sh/uv/getting-started/installation/"
end
