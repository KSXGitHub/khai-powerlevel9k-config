
# Define some icons (Font Awesome)
export POWERLEVEL9K_FOLDER_ICON=$'\uF115'
export POWERLEVEL9K_HOME_ICON=$'\uF015'
export POWERLEVEL9K_SERVER_ICON=$'\uF473'
export POWERLEVEL9K_WIFI_ICON=$'\uF1EB'
export POWERLEVEL9K_NETWORK_ICON=$POWERLEVEL9K_WIFI_ICON
export POWERLEVEL9K_CLOCK_ICON=$'\uF017'
export POWERLEVEL9K_EXECUTION_TIME_ICON=$POWERLEVEL9K_CLOCK_ICON
export POWERLEVEL9K_HDD_ICON=$'\uF0A0'
export POWERLEVEL9K_DISK_ICON=$POWERLEVEL9K_HDD_ICON
export POWERLEVEL9K_TERMINAL_ICON=$'\uF489'
export POWERLEVEL9K_PACKAGE_ICON=$'\uF487'
export POWERLEVEL9K_CRATE_ICON=$POWERLEVEL9K_PACKAGE_ICON
export POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uF09B'
export POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=$'\uF171'
export POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uF296'
export POWERLEVEL9K_VCS_GIT_ICON=$'\uF1D3'
export POWERLEVEL9K_VCS_TAG_ICON=$'\uF02B'
export POWERLEVEL9K_COMMIT_ICON=$'\uF417'
export POWERLEVEL9K_LINUX_ICON=$'\uF17C'
export POWERLEVEL9K_FREEBSD_ICON=$'\uF30E'
export POWERLEVEL9K_WINDOWS_ICON=$'\uF17A'
export POWERLEVEL9K_ANDROID_ICON=$'\uE70E'
export POWERLEVEL9K_NODE_ICON=$'\uE718'
export POWERLEVEL9K_JAVASCRIPT_ICON=$'\uE60C'
export POWERLEVEL9K_RUST_ICON=$'\uE7A8'
export POWERLEVEL9K_RUBY_ICON=$'\uE21E'
export POWERLEVEL9K_GO_ICON=$'\uE626'
export POWERLEVEL9K_PYTHON_ICON=$'\uE606'
export POWERLEVEL9K_SWIFT_ICON=$'\uE755'
export POWERLEVEL9K_APPLE_ICON=$'\uF179'
export POWERLEVEL9K_GOOGLE_ICON=$'\uF1A0'
export POWERLEVEL9K_FACEBOOK_ICON=$'\uF09A'
export POWERLEVEL9K_NPM_ICON=$'\uE71E'

# Configure prompts
export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
export POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
export POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
export POWERLEVEL9K_DISABLE_RPROMPT=false
export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
export POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=' (zsh) '$POWERLEVEL9K_TERMINAL_ICON' '

# Prompt segments
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon context ssh dir dir_writable rbenv vcs
  custom_nothing custom_package_json
)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status root_indicator background_jobs battery ip time command_execution_time
)

# Custom segments
export POWERLEVEL9K_CUSTOM_NOTHING=zsh_nothing
export POWERLEVEL9K_CUSTOM_PACKAGE_JSON=zsh_package_json

function zsh_nothing () {
  echo '' # Nothing
}

# Functions: If working directory contains package.json, show nodejs information
function zsh_package_json () {
  local pkgjson=$(pwd)/package.json
  if [[ -f $pkgjson ]]; then
    local nodever npmver pkgver

    if [[ $POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NODEVER != 'false' ]]; then
      nodever=($POWERLEVEL9K_NODE_ICON $(node --version))
    fi

    if [[ $POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NPMVER != 'false' ]]; then
      npmver=($POWERLEVEL9K_NPM_ICON' '$(npm --version))
    fi

    if [[ $POWERLEVEL9K_CUSTOM_PACKAGE_JSON_PKGVER != 'false' ]]; then
      local actualpkgver=$(node -p "require('$pkgjson').version || ''")
      [[ -z $actualpkgver ]] || pkgver=($POWERLEVEL9K_PACKAGE_ICON $actualpkgver)
    fi

    env echo -n $nodever $npmver $pkgver
  fi
}
