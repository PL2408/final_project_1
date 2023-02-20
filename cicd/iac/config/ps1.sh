blk='\e[0;30m' # Black - normal
red='\e[0;31m' # Red
grn='\e[0;32m' # Green
ylw='\e[0;33m' # Yellow
blu='\e[0;34m' # Blue
pur='\e[0;35m' # Purple
cyn='\e[0;36m' # Cyan
wht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underlined
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
rst='\e[0m'    # Text Reset

case "${HOSTNAME}" in
    "jenkins_server")
        color=$cyn
        ;;
    "jenkins_agent")
        color=$ylw
        ;;
    "web_server")
        color=$grn
        ;;
    *)
        color=$wht
esac

if [ "`id -u`" -eq 0 ]; then
    PS1="\[$cyn\]┌\[$rst\][ \[$bldred\]\u\[$rst\]\[$grn\]@\[$color\]${HOSTNAME}\[$rst\] ] [ \[$cyn\]\t\[$rst\] ] [\[$bldylw\]\w\[$rst\]]\n\[$cyn\]└>\[$rst\] "
else
    PS1="\[$cyn\]┌\[$rst\][ \[$bldwht\]\u\[$rst\]\[$grn\]@\[$color\]${HOSTNAME}\[$rst\] ] [ \[$cyn\]\t\[$rst\] ] [\[$bldylw\]\w\[$rst\]]\n\[$cyn\]└>\[$rst\] "
fi