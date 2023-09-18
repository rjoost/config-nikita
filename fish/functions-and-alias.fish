# af <cmd> - view definition of <cmd>
function af
    type $argv
end

function la
    command la # overwrite `la` fish builtin function
end

# w - open current path in VSCode
# w <path> - open path in VSCode
#function w
#    if not set -q argv[1]
#        code-insiders .
#    else
#        code-insiders $argv
#    end
#end

# TODO: replace it with CLI that will autocomplete from `package.json scripts` as you type
# with fzf matching
function :
    if not set -q argv[1]
        bun dev
    else
        bun $argv
    end
end

function w
    if not set -q argv[1]
        zed .
    else
        zed $argv
    end
end

function W
    if not set -q argv[1]
        open -a /Applications/Cursor\ Nightly.app .
    else
        open -a /Applications/Cursor\ Nightly.app $argv
    end
end

# TODO: pass arg for extension, and also the command to rerun
# for now `js` is hardcoded
#function W
#    watchexec --no-vcs-ignore --restart --exts js "tput reset && $argv" --project-origin .
#end

function wb
    watchexec --no-vcs-ignore --restart --exts ts "tput reset && bun run $argv" --project-origin .
end

function wbi
    watchexec --no-vcs-ignore --restart --exts ts "tput reset && bun run index.ts" --project-origin .
end

function wbk
    watchexec --no-vcs-ignore --restart --exts ts "tput reset && bun run ../bin/$argv" --project-origin .
end

function wt
    watchexec --no-vcs-ignore --restart --exts ts "tput reset && tsx $argv" --project-origin .
end

function wd
    watchexec --no-vcs-ignore --restart --exts ts "tput reset && deno run $argv" --project-origin .
end

# function wn
#     watchexec --restart --exts ts "tput reset && node $argv" --project-origin .
# end

function wn
    watchexec --no-vcs-ignore --restart --exts ts "tput reset && tsx $argv" --project-origin .
end

function wgm
    watchexec --no-vcs-ignore --restart --exts go "tput reset && go run $argv" --project-origin .
end

function wgm
    watchexec --no-vcs-ignore --restart --exts go "tput reset && go run main.go" --project-origin .
end

# r - run `cargo run` when rust files change
function r
    if not set -q argv[1]
        cargo watch -q -- sh -c "tput reset && cargo run -q"
    else
        cargo watch -q -- sh -c "tput reset && cargo run -q -- $argv"
    end
end

# rb - put rust binary into PATH in debug
function rb
    set current_folder (basename (pwd))
    cargo build
    if test $status -eq 0
        mv target/debug/$current_folder ~/src/config/bin
    end
end

# R <cmd> - cargo <cmd>
function R
    cargo $argv
end

# TODO: it skips doing doc-tests, have another function for it?
# rt - `cargo test` on rust file changes
function rt
    if not set -q argv[1]
        cargo watch -q -- sh -c "tput reset && cargo test -q --lib"
    else
        # cargo $argv
    end
end

# n - `bun dev`
# n <cmd> - `bun run ..`
function n
    if not set -q argv[1]
        bun run dev
    else
        bun run $argv
    end
end

# p - pnpm install dependencies
# p <cmd> - pnpm <cmd>
function p
    if not set -q argv[1]
        pnpm i
    else
        pnpm $argv
    end
end

# R <flags or things to pass to CLI>
function R
    cargo watch -q -x "run -q -- $argv"
end

# ga. - commit all with `.` as message
function g.
    git add .
    git commit -m "."
    git push
end

# gi - go get package
# `go get -u github.com/spf13/cobra@latest
# function gi
#     go get -u github.com/leaanthony/clir@latest
# end

# envsource - source .env files (https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc)
function envsource
    for line in (cat $argv | grep -v '^#')
        set item (string split -m 1 '=' $line)
        set -gx $item[1] $item[2]
        echo "Exported key $item[1]"
    end
end

# pw <package.json command> - rerun command if .ts files change
function pw
    watchexec --no-vcs-ignore --restart --exts ts "tput reset && pnpm --silent run $argv" --project-origin .
end

# Aliases
# cd places
alias d="cd"
alias da="cd ~/src"
alias dg="cd ~/src/config"
alias dt='cd ~/test'
alias de="cd ~/Desktop"

# rust
# alias rbnowarning="RUSTFLAGS="-A warnings" cargo build"

# run code fast
alias :ts="cd ~/src/ts && bun dev"

# other
alias a="eza" # list files
alias cwd='pwd | pbcopy'
alias v="mv" # move files/folders or rename
alias sf="source ~/.config/fish/config.fish" # source fish config
alias rr="rm -rf"
alias md="mkdir"
alias wgi="watchexec --restart --exts go \"tput reset && go install .\""
alias wg="watchexec --restart --exts go \"tput reset && go run .\""
alias dw="deno task watch"
alias :i="bun i"
alias :d="bun dev"
alias :t="bun test --watch"
