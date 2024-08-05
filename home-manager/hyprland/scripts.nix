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

      clipShow = writeShellScript "clipShow" ''
        export CLIP=true
        tmp_dir="/tmp/cliphist"
        rm -rf "$tmp_dir"
        mkdir -p "$tmp_dir"

        read -r -d "" prog <<EOF
        /^[0-9]+\s<meta http-equiv=/ { next }
        match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
            system("echo " grp[1] "\\\\\t | cliphist decode >$tmp_dir/"grp[1]"."grp[3])
            print \$0"\0icon\x1f$tmp_dir/"grp[1]"."grp[3]
            next
        }
        1
        EOF
        cliphist list | gawk "$prog" | rofi -dmenu -i -p '' -theme preview | cliphist decode | wl-copy
      '';
    };
  };
}
