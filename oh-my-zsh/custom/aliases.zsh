if [[ "$OSTYPE" == linux* && -r /etc/os-release ]]; then
  source /etc/os-release

  case " ${ID:-} ${ID_LIKE:-} " in
    *" arch "*|*" manjaro "*)
      alias yua="yay -Sua --aur"
      alias upd="sudo pacman -Syu"
      ;;
  esac
fi
