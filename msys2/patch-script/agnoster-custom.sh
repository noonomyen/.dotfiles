#!/usr/bin/bash

cp $ZSH/themes/agnoster.zsh-theme $ZSH_CUSTOM/themes/agnoster-custom.zsh-theme
patch $ZSH_CUSTOM/themes/agnoster-custom.zsh-theme < agnoster-custom.patch
