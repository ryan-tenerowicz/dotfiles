alias zshconfig='nvim ~/.zshrc; source ~/.zshrc'

##? Clone a plugin, identify its init file, source it, and add it to your fpath.
function plugin-load {
  local plugin repo commitsha plugdir initfile initfiles=()
  : ${ZPLUGINDIR:=${ZDOTDIR:-~/.config/zsh}/plugins}
  for plugin in $@; do
    repo="$plugin"
    clone_args=(-q --depth 1 --recursive --shallow-submodules)
    # Pin repo to a specific commit sha if provided
    if [[ "$plugin" == *'@'* ]]; then
      repo="${plugin%@*}"
      commitsha="${plugin#*@}"
      clone_args+=(--no-checkout)
    fi
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone "${clone_args[@]}" https://github.com/$repo $plugdir
      if [[ -n "$commitsha" ]]; then
        git -C $plugdir fetch -q origin "$commitsha"
        git -C $plugdir checkout -q "$commitsha"
      fi
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
      (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
      ln -sf $initfiles[1] $initfile
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

repos=(
  'zsh-users/zsh-completions@8d5a945c93a6069f3f305219f373b61d2f05472c'
  'zsh-users/zsh-syntax-highlighting@5eb677bb0fa9a3e60f0eff031dc13926e093df92'
  'zsh-users/zsh-autosuggestions@85919cd1ffa7d2d5412f6d3fe437ebdbeeec4fc5'
  'joshskidmore/zsh-fzf-history-search@d5a9730b5b4cb0b39959f7f1044f9c52743832ba'
)

source <(fzf --zsh)
ZSH_FZF_HISTORY_END_OF_LINE=true
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=false
ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS='--height=10 --reverse'

plugin-load $repos

# F1 to accept autosuggestion
bindkey '^[OP' autosuggest-accept

export PROMPT='%F{111}%m:%F{2}%~ $%f '
export MUJOCO_PATH="/home/ryan/.mujoco/mujoco-3.3.5-linux-x86_64/mujoco-3.3.5/bin/"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# hist size in memory
HISTSIZE=1000000000
# hist size saved to file
SAVEHIST=1000000000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
HISTFILE=~/.zsh_history
