#! /bin/bash
# This script does the following actions:
#    * stores all directory names to an array,
#    * splits the large phrases to words
#    * capitalizes the first letter
#    * replaces underscores with spaces
#    * renames/moves the folder
#

declare -a dirs
i=1

# add directories to the array
for d in */
do
    dirs[i++]="${d%/}"
done

for((i=1;i<=${#dirs[@]};i++))
do
    # split input into an array of words
    read -ra words <<<"${dirs[i]}"
    # initialize output variable
    output=""

    # loop over all words
    for word in "${words[@]}"; do
      # add capitalized 1st letter
      output+="$(tr '[:lower:]' '[:upper:]' <<<"${word:0:1}")"
      # add lowercase version of rest of word
      output+="$(tr '[:upper:]' '[:lower:]' <<<"${word:1}")"
      # add space between words
      output+=" "
    done

    # replace underscores with spaces
    echo $i "${dirs[i]} -> ${output//_/ }"
    echo
    `mv "${dirs[i]}" "${output//_/ }"`
done

echo "There are ${#dirs[@]} dirs in the current path that were renamed"
