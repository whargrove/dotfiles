# pnpm setup
set -l pnpm_found 0

if test -d $HOME/.local/share/pnpm
    set -gx PNPM_HOME $HOME/.local/share/pnpm
    fish_add_path $PNPM_HOME
    if command -q pnpm
        set pnpm_found 1
    end
end

if test $pnpm_found -eq 0
    echo "pnpm not found. Please install it from https://pnpm.io/installation"
end
