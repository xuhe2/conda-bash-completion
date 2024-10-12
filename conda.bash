# a global var to store the current word
cur=""
# function to get conda env names
function get_conda_envs() {
    conda env list | awk '{print $1}' | grep -v '^#'
}

function activate_completion() {
    compgen -W "$(get_conda_envs)" -- "$cur"
}

function create_completion() {
    local args="--name python="
    compgen -W "${args}" -- "$cur"
}

_conda_completion() {
    # get the current word
    cur="${COMP_WORDS[COMP_CWORD]}"

    COMPREPLY=( $(compgen -W "activate deactivate create" -- "$cur") )
    
    case ${COMP_WORDS[COMP_CWORD-1]} in
        "activate")
            COMPREPLY=( $(activate_completion) )
            ;;
        "create")
            COMPREPLY=( $(create_completion) )
            ;;
    esac
}

complete -F _conda_completion conda