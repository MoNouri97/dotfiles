# !/bin/bash

BBlue='\033[1;34m'        # Blue Bold
NC='\033[0m' # No Color

# project
if [ $1 ] && [ $2 ];then
	PROJECT="/mnt/D_partition/Download/Dev/$1/$2"
else
	PROJECT="/mnt/D_partition/Download/Dev/Java/merch-team"
fi

ROUTE="https://www.notion.so/Merchandising-Team-7b57a5c2c0684f80a10b0464d2f11317"
ROUTE2="https://open.spotify.com/"
BROWSER="vivaldi"
EDITOR="code"

# echo "$BBlue openning$NC $ROUTE"
# xdg-open $ROUTE & #Say you want a terminal in the 0th workspace
# echo "$BBlue openning$NC $ROUTE2"
# xdg-open $ROUTE2 & #Say you want a terminal in the 0th workspace
echo "$BBlue openning$NC $BROWSER"
browse $ROUTE &> /dev/null
browse $ROUTE2 &> /dev/null
echo "$BBlue openning$NC $PROJECT $BBlue with$NC $EDITOR"
$EDITOR $PROJECT  #Maybe a file browser too

opened=false
while true ; do
sleep 1	
wmctrl -l | grep -i $EDITOR
if [ ! $? -eq 0 ]; then
continue;
fi
wmctrl -l | grep -i $BROWSER
if [ $? -eq 0 ]; then
break;
fi
done

# wmctrl -s 0 #Switches to workspace 0 [workspaces are numbered from 0]
wmctrl -r $EDITOR -t 1
# wmctrl -r vivaldi -t 0
echo "$BBlue DONE$NC"
return 0


# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

# Reset
# R='\033[0m'       # Text Reset

# Regular Colors
# Black='\033[0;30m'        # Black
# Red='\033[0;31m'          # Red
# Green='\033[0;32m'        # Green
# Yellow='\033[0;33m'       # Yellow
# Blue='\033[0;34m'         # Blue
# Purple='\033[0;35m'       # Purple
# Cyan='\033[0;36m'         # Cyan
# White='\033[0;37m'        # White

# # Bold
# BBlack='\033[1;30m'       # Black
# BRed='\033[1;31m'         # Red
# BGreen='\033[1;32m'       # Green
# BYellow='\033[1;33m'      # Yellow
# BBlue='\033[1;34m'        # Blue
# BPurple='\033[1;35m'      # Purple
# BCyan='\033[1;36m'        # Cyan
# BWhite='\033[1;37m'       # White

# # Underline
# UBlack='\033[4;30m'       # Black
# URed='\033[4;31m'         # Red
# UGreen='\033[4;32m'       # Green
# UYellow='\033[4;33m'      # Yellow
# UBlue='\033[4;34m'        # Blue
# UPurple='\033[4;35m'      # Purple
# UCyan='\033[4;36m'        # Cyan
# UWhite='\033[4;37m'       # White

# # Background
# On_Black='\033[40m'       # Black
# On_Red='\033[41m'         # Red
# On_Green='\033[42m'       # Green
# On_Yellow='\033[43m'      # Yellow
# On_Blue='\033[44m'        # Blue
# On_Purple='\033[45m'      # Purple
# On_Cyan='\033[46m'        # Cyan
# On_White='\033[47m'       # White

# # High Intensity
# IBlack='\033[0;90m'       # Black
# IRed='\033[0;91m'         # Red
# IGreen='\033[0;92m'       # Green
# IYellow='\033[0;93m'      # Yellow
# IBlue='\033[0;94m'        # Blue
# IPurple='\033[0;95m'      # Purple
# ICyan='\033[0;96m'        # Cyan
# IWhite='\033[0;97m'       # White

# # Bold High Intensity
# BIBlack='\033[1;90m'      # Black
# BIRed='\033[1;91m'        # Red
# BIGreen='\033[1;92m'      # Green
# BIYellow='\033[1;93m'     # Yellow
# BIBlue='\033[1;94m'       # Blue
# BIPurple='\033[1;95m'     # Purple
# BICyan='\033[1;96m'       # Cyan
# BIWhite='\033[1;97m'      # White

# # High Intensity backgrounds
# On_IBlack='\033[0;100m'   # Black
# On_IRed='\033[0;101m'     # Red
# On_IGreen='\033[0;102m'   # Green
# On_IYellow='\033[0;103m'  # Yellow
# On_IBlue='\033[0;104m'    # Blue
# On_IPurple='\033[0;105m'  # Purple
# On_ICyan='\033[0;106m'    # Cyan
# On_IWhite='\033[0;107m'   # White
