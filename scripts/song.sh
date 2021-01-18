#!/bin/bash
# sometimes i use tabs and sometimes i use spaces but theres one thing that
# i do 100% of the time and thats not give a fuck

list_players() { # this just gets rid of the extra garbage on the end of kdeconnect
	playerctl -l |  sed 's/\.[^[[:blank:]]*//'
}

# run through every player, and once we find the one that's playing, echo its details
one_player_active() {
	for i in $(list_players); do
		if playerctl status -p "$i" | grep -q 'Playing' ; then
			echo "$(playerctl metadata artist -p "$i") - $(playerctl metadata title -p "$i")"
			echo "$(playerctl metadata title -p "$i")"
		fi
	done
}
case $(playerctl status -a | grep -c Playing) in
	# the i3 bar thingy just wont show the block if it exits with nothing
	0) exit ;;
	1) one_player_active ;;
	# right now this script will just ignore my phone if theres more than one active player
        # if theres multiple players that arent kdeconnect, fuck knows whatll happen lol	
	*)
	  echo "$(playerctl metadata artist -i kdeconnect) - $(playerctl metadata title -i kdeconnect)"
	  echo "$(playerctl metadata title -i kdeconnect)"
	;;
esac


