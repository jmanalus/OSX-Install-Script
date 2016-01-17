#!/usr/bin/env sh

# NOTE: Before running this script,
#   Make sure XCode commandline tools installed,
#   and terms and conditions accepted.

# ------------------- #
#      Helpers        #
# ------------------- #

prompt(){
  read var
  if [[ -z "$var" ]]; then
    prompt
    return 1
  else
    echo "$var"
  fi
}

console.log(){
  printf "%s\n" "$1"
}
console.error(){
  local callerFunction="${FUNCNAME[1]}"
  local errorPrompt=$(echo "Error: '$callerFunction'")
  printf "%s" "$errorPrompt"
}
console.warn(){
  printf '\e[4;33m%-6s\e[m' "Warning"
  printf ": %s\n" "$1"
}

is_true(){
  local result
  if [ "$1" ]; then
    result=true
  fi
  echo "$result"
}
is_file(){
  echo $(is_true "-f $1")
}
is_directory(){
  echo $(is_true "-d $1")
}
is_installed(){
  if hash $1 2>/dev/null; then
    echo true
  fi
}

# ------------------- #
#    Script Setup     #
# ------------------- #

dir(){
  echo ~/"osx-setup"
}

finish.get(){
  echo $(is_file "$dir"/.finish)
}

finish.set(){
  $(touch "$dir"/.finish)
}

# ------------------- #
#   Installations     #
# ------------------- #

install.brew(){
  local bool=$(is_installed brew)
  if [[ -z "$bool" ]]; then
    console.log "Installing Homebrew...\n"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    console.warn "Homebrew already installed!"
  fi
}

install.brew.cask(){
  brew install caskroom/cask/brew-cask
}

install.brew.git(){
  brew install git
}

install.brew.misc(){
  brew install wget
}

install.brew.cask.apps(){
  brew cask install google-chrome
  brew cask install firefox
  brew cask install vlc
  brew cask install flux
  brew cask install spotify
  brew cask install atom
  brew cask install 1password
  brew cask install sketch
  brew cask install sketch-toolbox
  brew cask install adobe-creative-cloud
  brew cask install KeepingYouAwake
  brew cask install wunderlist
  brew cask install dropbox
  brew cask install wunderlist
  brew cask install framer-studio
  brew cask install github-desktop

}

## get from App Store
#brew cask install --appdir="/Applications" wunderlist
#brew cask install --appdir="/Applications" bettersnaptool


# ------------------- #
#         Main        #
# ------------------- #

osx_setup(){
  console.log "Welcome to OSX Setup :D"
  console.log ""
  config.install_dir
  install.brew
  install.brew.git
  config.git
  install.brew.misc
  install.brew.cask
  install.brew.cask.apps
  # install.node    # TODO
  # install.rvm     # TODO
  # finish.set      # TODO
}

# Run everything
osx_setup

# helpers