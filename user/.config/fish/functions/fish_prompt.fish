function fish_prompt --description 'Write out the prompt'
  set stat $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __fish_color_blue
    set -g __fish_color_blue (set_color -o (hostname | md5sum | head -c 6))
  end

  #Set the color for the status depending on the value
  set __fish_color_status (set_color -o green)
  if test $stat -gt 0
    set __fish_color_status (set_color -o red)
  end

  set -l display_pwd (pwd | sed "s|^$HOME|~|")

  printf '%s(%s)%s ' "$__fish_color_status" "$stat" "$__fish_prompt_normal"

  printf '%s%s@%s%s ' "$__fish_color_blue" "$USER" "$__fish_prompt_hostname" "$__fish_prompt_normal"

  printf '%s%s ' "$display_pwd" (__fish_git_prompt)

  if set -q IN_NIX_SHELL
    if not set -q __fish_color_red
      set -g __fish_color_red (set_color -o red)
    end
    printf "%s<NIX: $name>%s " "$__fish_color_red" "$__fish_prompt_normal"
  end

  printf '\f\r $ '
end
