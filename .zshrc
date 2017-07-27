# vim: foldmarker={{--,--}} foldlevel=0 foldmethod=marker
#http://wiki.ms.com/NBUeng/TerminalSetup
# Oh-my-zsh {{--
export ZSH=/Users/Jialun/.oh-my-zsh
plugins=(git golang tmux rust)
source $ZSH/oh-my-zsh.sh
# --}}
# Hist {{--
#  HISTFILE="/var/tmp/zsh_hist.`whoami`.$$"
  HISTFILE="$HOME/.zsh/zsh_hist"
  HISTSIZE=10000
  SAVEHIST=10000
# --}}

# Environment Variable{{--
  export EDITOR=vim # or emacs, or nano, or some other heathen editor
  export P4EDITOR=vim
  #export P4DIFF=vimdiff
  export P4DIFF='git diff --no-index'
  export P4CONFIG=.p4config
  export PAGER=less                  # because less is more
  export LANG=en_US.UTF-8
  export CLICOLOR=1

  export SHELL=`which zsh`
  export GOPATH="$HOME/Projects/goproj"
  export GOROOT="/usr/local/go"
  export LLVMROOT="/usr/local/Cellar/llvm/3.9.0"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
# --}}
# Options {{--
  umask 077
  #List jobs in the long format by default.
  setopt long_list_jobs
  #If a pattern for filename generation has no matches, print an error, instead
  #of leaving it unchanged in the argument list. This also applies to file
  #expansion of an initial '~' or '='.
  setopt nomatch 
  #Report the status of background jobs immediately, rather than waiting until 
  #just before printing a prompt.
  setopt notify 
  #If set, parameter expansion, command substitution and arithmetic expansion are 
  #performed in prompts. Substitutions within prompts do not affect the command status.
  setopt prompt_subst 
  #Don't push multiple copies of the same directory onto the directory stack.
  setopt pushd_ignore_dups
  #If this is set, zsh sessions will append their history list to the history
  #file, rather than replace it. Thus, multiple parallel zsh sessions will all
  #have the new entries from their history lists added to the history file, in
  #the order that they exit. The file will still be periodically re-written to
  #trim it when the number of lines grows 20% beyond the value specified by
  #$SAVEHIST (see also the HIST_SAVE_BY_COPY option).
  setopt appendhistory
  #If a command is issued that can't be executed as a normal command, and the command 
  #is the name of a directory, perform the cd command to that directory.
  setopt auto_cd
  #Perform textual history expansion, csh-style, treating the character '!'
  #specially.
  setopt bang_hist
  #Assume that the terminal displays combining characters correctly.
  #Specifically, if a base alphanumeric character is followed by one or more
  #zero-width punctuation characters, assume that the zero-width characters will
  #be displayed as modifications to the base character within the same width.
  #Not all terminals handle this. If this option is not set, zero-width
  #characters are displayed separately with special mark-up.
  #If this option is set, the pattern test [[:WORD:]] matches a zero-width
  #punctuation character on the assumption that it will be used as part of a
  #word in combination with a word character. Otherwise the base shell does not
  #handle combining characters specially.]]
  setopt combining_chars
  #Treat the '#', '~' and '^' characters as part of patterns for filename
  #generation, etc. (An initial unquoted '~' always produces named directory
  #expansion.)
  setopt extendedglob
  #If querying the user before executing 'rm *' or 'rm path/*', first wait ten
  #seconds and ignore anything typed in that time. This avoids the problem of
  #reflexively answering 'yes' to the query when one didn't really mean it. The
  #wait and query can always be avoided by expanding the '*' in ZLE (with tab).)
  setopt RM_STAR_WAIT
  setopt NOCLOBBER
  #Try to correct the spelling of all arguments in a line.
  setopt correctall
  setopt no_beep
  #Allow comments even in interactive shells.
  setopt interactivecomments
  #If a new command line being added to the history list duplicates an older
  #one, the older command is removed from the list (even if it is not the
  #previous event).
  setopt hist_ignore_all_dups
  #Make cd push the old directory onto the directory stack.
  setopt autopushd 
  #Exchanges the meanings of '+' and '-' when used with a number to specify a directory in the stack.
  setopt pushdminus 
  #Do not print the directory stack after pushd or popd.
  setopt pushdsilent 
  #Have pushd with no arguments act like 'pushd $HOME'.
  setopt pushdtohome
  #Automatically list choices on an ambiguous completion.
  setopt AUTOLIST
  #Automatically use menu completion after the second consecutive request for completion, 
  #for example by pressing the tab key repeatedly. This option is overridden by MENU_COMPLETE.
  setopt AUTOMENU
  #This options works like APPEND_HISTORY except that new history lines are
  #added to the $HISTFILE incrementally (as soon as they are entered), rather
  #than waiting until the shell exits. The file will still be periodically
  #re-written to trim it when the number of lines grows 20% beyond the value
  #specified by $SAVEHIST
  setopt INC_APPEND_HISTORY
  #bindkey -e
  bindkey -v
  bindkey -M viins 'jk' vi-cmd-mode
  DIRSTACKSIZE=16
# --}}


# Custom Functions {{--
  autoload -U colors && colors
  module >& /dev/null
  #color man pages
  man() {
    env \
      LESS_TERMCAP_mb=$(printf "\e[1;31m") \
      LESS_TERMCAP_md=$(printf "\e[1;31m") \
      LESS_TERMCAP_me=$(printf "\e[0m") \
      LESS_TERMCAP_se=$(printf "\e[0m") \
      LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
      LESS_TERMCAP_ue=$(printf "\e[0m") \
      LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
  }
  # vim Mode
  vim_ins_mode="%{$fg[green]%}[I]%{$reset_color%}"
  vim_cmd_mode="%{$fg[red]%}[N]%{$reset_color%}"
  vim_mode=$vim_ins_mode
  function zle-keymap-select {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
      zle reset-prompt
  }
  zle -N zle-keymap-select

  function zle-line-finish {
    vim_mode=$vim_ins_mode
  }
  zle -N zle-line-finish
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^?' backward-delete-char
# --}}

# Completion {{--
  zstyle ':completion::complete:*' use-cache 1
  zstyle ':completion:*' verbose yes
  zstyle ':completion:*' rehash yes
  zstyle ':completion:*' menu select=2
  zstyle ':completion:*:*:default' force-list always
  zstyle ':completion:*' list-prompt ''
  zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
  zstyle ':completion:*:manuals' separate-sections true
  zstyle ':completion:*:manuals.(^1*)' insert-sections true

  zstyle ':completion:*:match:*' original only
  zstyle ':completion::prefix-1:*' completer _complete
  zstyle ':completion:predict:*' completer _complete
  zstyle ':completion:incremental:*' completer _complete _correct
  zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

  # auto complete path
  zstyle ':completion:*' expand 'yes'
  zstyle ':completion:*' squeeze-shlashes 'yes'
  zstyle ':completion::complete:*' '\\'

  # colorize auto completion lists
  zmodload zsh/complist
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
  zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -u jialun -U jialun -o pid,user,rss,cmd'

  # case insensitive completion
  zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
  # correct spelling
  zstyle ':completion:*' completer _complete _match _approximate
  zstyle ':completion:*:match:*' original only
  zstyle ':completion:*:approximate:*' max-errors 1 numeric

  #kill completion  
  #compdef pkill=kill
  #compdef pkill=killall
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:*:*:*:processes' force-list always
  #zstyle ':completion:*:processes' command 'ps -au$USER'

  # group auto completion prompts 
  zstyle ':completion:*:matches' group 'yes'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*:options' description 'yes'
  zstyle ':completion:*:options' auto-description '%d'
  zstyle ':completion:*:descriptions' format $'\e[01;36m -- %d --\e[0m'
  zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
  zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
  zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

  #load autocomplete
  autoload -Uz compinit
  compinit -i -u
# --}}
# Alias {{--
  alias 'mkdir=mkdir -p'
  alias 'cp=cp -i'
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias 'l=ls -lah'
  #alias 'ls=ls --color=auto'
  alias 'll=ls -l'
  alias 'la=ls -a'
  alias 'lrt=ls -lhart'
  alias 'tmux=tmux -2'
  alias 'v=vim -p'
  alias 's=ssh'
  alias "ed=ed -p '>>'"
  alias 'nm=nm -s -C'
  alias 'gdiff=git diff --no-index'
  #lab compile flags
  LABFLAGS="-Wall -Werror -ansi -pedantic -std=c++11"
  CXX="clang++"
  CC="clang"
  alias CXX="$CXX $LABFLAGS"
  alias CC="$CC $LABFLAGS"
  alias myg++="g++ $LABFLAGS"
# --}}


# Prompt {{--
PROMPT='%{$fg[yellow]%}%n%f %{$fg[magenta]%}%3c 
${vim_mode} %{$fg[red]%}>%{$fg[green]%}>%{$fg[blue]%}> %{$reset_color%}'
# --}}

path=($LLVMROOT/bin $HOME/bin $GOPATH/bin $path)

# --}}
# fzf {{--
source ~/.zsh/functions/fzf/completion.zsh
source ~/.zsh/functions/fzf/key-bindings.zsh
# --}}
