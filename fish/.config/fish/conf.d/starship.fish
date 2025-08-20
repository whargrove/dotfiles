# starship setup
set -l starship_found 0

if command -q starship
    starship init fish | source
    set starship_found 1
end

if test $starship_found -eq 0
    echo "starship not found. Please install it from https://starship.rs/guide/#🚀-installation"
end
