# usage> watch
# short> start the hugo server
#  long> start the hugo server
#                          __ ___       __   __              __  __
# |  | |  | |  |  __ |\/| |_   |   /\  |__) |_  \_/    |\/| |_  |  \ |  /\
# |/\| |/\| |/\|     |  | |__  |  /--\ | \  |__ / \ .  |  | |__ |__/ | /--\
#
source <(clog Inc)

CMD="hugo server --buildDrafts --environment staging"
fnInfo "running $cC$CMD$cX\n"

hugo server --buildDrafts