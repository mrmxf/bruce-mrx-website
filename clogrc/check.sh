 # clog> check
# short> pre-build & deploy checks
# extra> $1 = "ignore-errors" or "no-fixup"
#                                                  _                                                     _   _
#  __ __ __ __ __ __ __ __ __  ___   _ __    ___  | |_   __ _   _ _   ___  __ __  ___   _ __    ___   __| | (_)  __ _
#  \ V  V / \ V  V / \ V  V / |___| | '  \  / -_) |  _| / _` | | '_| / -_) \ \ / |___| | '  \  / -_) / _` | | | / _` |
#   \_/\_/   \_/\_/   \_/\_/        |_|_|_| \___|  \__| \__,_| |_|   \___| /_\_\       |_|_|_| \___| \__,_| |_| \__,_|
[ -n "$CHECK_ALREADY_SOURCED" ] && return 0
CHECK_ALREADY_SOURCED=YES
[ -f clogrc/_inc.sh   ] && source clogrc/_inc.sh    # helper functions
[ -f clogrc/common.sh ] && source clogrc/common.sh  # helper functions

fPrompt "${cC}Check$cT    Project$cS $PROJECT$cT on $cI$bCPU $bOSV$cX?" "Yn" 6
[ $? -gt 0 ] && return 0    # yes was selected

printf "${cC}Checking$cT Project$cS $PROJECT$cT on $cI$bCPU $bOSV$cX\n"

ignoreErrs=""; [[ "$1" == "ignore-errors" ]] && ignoreErrs="YES"
noFix=""     ; [[ "$1" == "no-fixup"      ]] && ignoreErrs="YES" && noFix="YES"

# --- status ------------------------------------------------------------------
OOPS=0                                   # non zero is bad - count the problems
PROJECT=$(basename $(pwd))

# --- git repo dependencies ---------------------------------------------------
dC=() ; dVer=()
#n="opentsg-node"   ; dName=("$n");  dRepo=("https://github.com/mrmxf/$n.git")

# --- git working tree handling -----------------------------------------------
issue=$(git status | grep 'not stage')
[ -n "$issue" ] && printf "${cE}Stage$cT or$cW Stash$cT changes before build$cX\n" && ((OOPS++))

issue=$(git status | grep 'hanges to be comm')
[ -n "$issue" ]  && printf "${cE}Commit$cT changes before build$cX\n" && ((OOPS++))

issue=$(git status | grep 'branch is ahead')
[ -n "$issue" ]  && printf "${cE}Push$cT changes before build$cX\n" && ((OOPS++))

issue=$(git status | grep 'working tree clean')
[ -z "$issue" ] && printf "${cE}Changes detected$cT Working tree must be$cS clean$cT before build$cX\n" && ((OOPS++))

# --- tag handling ------------------------------------------------------------
vLOCAL=$(git tag | tail -1)       && [ -z "$vLOCAL" ] && vLOCAL="notag"
vHEAD=$(git tag --points-at HEAD) && [ -z "$vHEAD" ]  && vHEAD="notag"
vREPO=$(getRemoteTag "default"); OOPS=$?

vREF="$vCODE"                                     # vCODE is defined in _inc.sh

hashLOCAL=$(git rev-list -n 1 $vLOCAL 2>/dev/null)
[ "$?" -gt 0 ] && hashLOCAL="none (L)"

# ^{} is the git suffix to dereference the commit hash
hashREPO=$(git ls-remote 2>/dev/null | grep "$vREF\^{}" | head -1 | sed -r 's/^([0-9a-f]{40}).*/\1/')
[ -z "$hashREPO" ] && hashREPO="none (R)"

# print out the BRANCH we're on - show main in red, rc in green
case "$gBRANCH" in
  "main") fReport "local" "MAIN branch" "$cE$gBRANCH" ;;
  "rc")   fReport "local"   "rc branch" "$cS$gBRANCH" ;;
  *)      fReport "local"      "branch" "$cT$gBRANCH" ;;
esac

#print out the matching tags
fReport "code"   "$vCodeType" "$cS" $vCODE isRef

fReport "local"  "git latest"  $(colourTag $vREF $vLOCAL)
fReport "local"  "git HEAD"    $(colourTag $vREF $vHEAD)
fReport "remote" "git latest"  $(colourTag $vREF $vREPO)

# get tag from the repos & update error count from the subprocess
for i in ${!dRepo[@]}; do
  ver=$( getRemoteTag ${dRepo[$i]} ) ; OOPS=$?
  dVer+=ver
  fReport "dep: github" ${dName[$i]} $cT $(colourTag $vREF $ver)
done

# --- local tag fixup ---------------------------------------------------------

if [[ "$vLOCAL" != "$vREF" ]] && [[ -z "$noFix" ]]; then
  printf "${cT}ref tag (${cW}$vREF$cX) != local tag  (${cW}$vLOCAL$cX)\n"
  fPrompt "${cT}Tag$cS $PROJECT$cT locally @ $vREF?$cX" "yN" 6
  if [ $? -eq 0 ] ; then # yes was selected
    printf "Tagging local with $vREF.\n"
    fTagLocal "$vREF" "matching tag to release ($vREF)"
    [ $? -gt 0 ] && printf "${cE}Abort$cX\n" && exit 1
    vLOCAL=$(git tag | tail -1)
  fi
fi

# --- head tag fixup ---------------------------------------------------------

if [[ "$vHEAD" != "$vREF" ]] && [[ -z "$noFix" ]]; then
  printf "${cT}ref tag (${cW}$vREF$cX) != head tag  (${cW}$vHEAD$cX)\n"
  fPrompt "${cT}delete local tag$cS $PROJECT$cT & re-tag to HEAD$cX" "yN" 6
  if [ $? -eq 0 ] ; then # yes was selected
    printf "Deleting local tag $vLOCAL.\n"
    git tag -d $vLOCAL
    [ $? -gt 0 ] && printf "${cE}Abort$cX\n" && exit 1
    printf "Re-tagging HEAD with $vREF.\n"
    fTagLocal "$vREF" "matching tag to release ($vREF)"
    [ $? -gt 0 ] && printf "${cE}Abort$cX\n" && exit 1
    vLOCAL=$(git tag | tail -1)
  fi
fi

# --- remote tag fixup --------------------------------------------------------

if [[ ( "$vHEAD" == "$vREF" ) && ( "$vREPO" != "$vREF" ) ]]  && [[ -z "$noFix" ]] ; then
  printf "${cT}ref tag ($cW%s$cX) != head tag ($cW%s$cX) or " "$vREF" "$vHEAD"
  printf "${cT}ref tag ($cW%s$cX) != remote tag ($cW%s$cX)\n" "$vREF" "$vREPO"
  fPrompt "${cT}Push$cS $PROJECT$cT to origin @ $vREF?$cX" "yN" 6
  if [ $? -eq 0 ] ; then # yes was selected
    printf "Pushing $vREF to origin.\n"
    fTagRemote "$vREF"
    [ $? -gt 0 ] && printf "${cE}Abort$cX\n" && exit 1
  fi
else
  # local and remote tags match but do they point to the right repo?
  if [[ "$hashLOCAL" != "$hashREPO" ]] ; then
    printf "${cW}Signature mismatch $cS$vREF$cT "
    printf "local($cI%s$cT) != repo($cW%s$cT)\n" "${hashLOCAL:0:8}" "${hashREPO:0:8}"
    fPrompt "${cT}Delete remote tag $cW$vREF?$cX" "yN" 6
  if [ $? -eq 0 ] ; then # yes was selected
    printf "Deleting remote tag $vREF with$cC git push origin :refs/tags/$vREF$cX.\n"
    git push origin :refs/tags/$vREF
    [ $? -gt 0 ] && printf "${cE}Abort$cX\n" && exit 1
  fi
  fi
fi

# --- environemnt variables ---------------------------------------------------

[ -z "$PROJECT " ] && printf "${cT}env$cE PROJECTI$cT not set.\n" && ((OOPS++))

# export the commit ID & date & type for the build
DATE=$(date +%F)
gBRANCH="$( git branch --show-current )"
[[ "main" == "$gBRANCH" ]] && gBRANCH=""

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# pull in any keys for uploads/builds etc.
[ ! -f .env ] && printf "${cI}No$cF .env$cT using default script values\n"
[   -f .env ] && source .env
# -----------------------------------------------------------------------------

# --- exit handling -----------------------------------------------------------
if [[ -n "$ignoreErrs" ]] ; then
  [ $OOPS -gt 0 ] && printf "${cT}Ignoring $cW$OOPS$cT issues from$cC check$cX.\n"
else
  if [ $OOPS -gt 0 ] ; then
    git status --branch --short
    printf "${cE}Error $cW$OOPS$cT issues from$cC check$cX.\n"
    exit $OOPS
  fi
fi
