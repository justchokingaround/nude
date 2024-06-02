{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) writeShellScript;
  inherit (lib) getExe mkOption types;

  jq = getExe pkgs.jq;
  zenity = lib.getExe pkgs.gnome.zenity;
in {
  options = {
    programs.hyprland.scripts = mkOption {
      description = "Scripts for Hyprland";
      type = types.attrs;
    };
  };

  config = {
    programs.hyprland.scripts = {
      pin = writeShellScript "pin" ''
        if ! hyprctl -j activewindow | ${jq} -e .floating; then
          hyprctl dispatch togglefloating
        fi
        hyprctl dispatch pin
      '';

      socket = writeShellScript "socket" ''
        ${getExe pkgs.socat} -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r event; do
          action="''${event%%>>*}"
          details="''${event##*>>}"

          case "$action" in
            workspace)
              monitor="$(hyprctl -j monitors | ${jq} -r '.[] | select(.focused == true) | .specialWorkspace')"
              if ${jq} -e '.id != 0' <<<"$monitor"; then
                hyprctl dispatch togglespecialworkspace "$(${jq} -r '.name' <<<"$monitor" | cut -d':' -f2)"
              fi
              ;;
          esac
        done
      '';

      rofiGpt = writeShellScript "rofiGpt" ''
        main() {
        	${zenity} --progress --text="Waiting for an answer" --pulsate &
        	[ $? -eq 1 ] && exit 1
        	PID=$!
        	answer=$(tgpt -q -w -i "$input")
        	echo "$answer" >/tmp/gpt-answer
        	kill $PID
        	input="$(${zenity} --text="$(printf "%s" "$answer" | sed "s/.\{200\}/&\n/g")" --title="rofi-gpt" --entry)"
        }

        input=$(rofi -dmenu -l 1 -p "  " 2>/dev/null)
        [ -z "$input" ] && exit 1

        while :; do
        	if [ -n "$input" ]; then
        		main "$input"
        	else
        		exit 0
        	fi
        done
      '';
    };
  };
}
