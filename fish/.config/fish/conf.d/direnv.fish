# direnv setup
set -l direnv_found 0

if command -q direnv
    direnv hook fish | source
    set direnv_found 1
end

if test $direnv_found -eq 0
    echo "direnv not found. Please install it from https://direnv.net/docs/installation.html"
end
