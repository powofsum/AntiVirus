#! /usr/bin/bash



virus_detected(){

    local file_path="$1"
    local file_name=$(basename "$1")
    local extension="${file_name##*.}"
    virus_content=("virus" "trojan" "malware" "worm" "ransomware")
    virus_extensions=("exe" "bat" "vbs" "scr" "ps1")

    #echo "$extension"

    for i in "${virus_extensions[@]}"
    do
        if [[ "$extension" == "$i" ]]
        then
            
            return 0
            
        fi
    done

    for j in "${virus_content[@]}"
    do
        if grep -qi "$j" "$file_path"
        then
        #echo "problem"
            return 0
        fi
    done

    #echo "no problem"
    return 1

}
