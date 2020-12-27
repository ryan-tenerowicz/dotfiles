# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ryan/.zsh/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/ryan/.zsh/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ryan/.zsh/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ryan/.zsh/fzf/shell/key-bindings.zsh"
