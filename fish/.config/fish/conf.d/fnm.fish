# fnm setup
set -l fnm_found 0

if test -d $HOME/.local/share/fnm/
    fish_add_path $HOME/.local/share/fnm/
    if command -q fnm
        fnm env --use-on-cd --version-file-strategy=recursive --shell fish | source
        set fnm_found 1
    end
end

if test $fnm_found -eq 0
    echo "fnm not found. Please install it from https://github.com/Schniz/fnm#installation"
end
