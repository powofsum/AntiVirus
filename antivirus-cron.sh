#! /usr/bin/bash

dir="$1"
malicious_dir="$2"

script_dir="$(dirname "$(realpath "$0")")"
last_file="$script_dir/directory-info.last"
new_file="$script_dir/directory-info.new"


virus_detected(){

    local file_path="$1"
    local file_name=$(basename "$1")
    local extension="${file_name##*.}"
    virus_content=("virus" "trojan" "malware" "worm" "ransomware")
    virus_extensions=("exe" "bat" "vbs" "scr" "ps1")

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
            return 0
        fi
    done

    return 1
}


scan_dir(){
    
for file in "$dir"/*
do
    if [ -f "$file" ]
    then
        if virus_detected "$file"
        then
            echo "$file is malicious and it is DELETED"
            move_to_malicious_dir "$file"
        fi
    fi
done

}


move_to_malicious_dir(){
    local distDIR="$malicious_dir"
    local source_dir="$dir"
    local malicious_file="$1"

    if [ -f "$malicious_file" ]
    then
        mv -i "$1" "$distDIR"
    fi
}


run_anti_virus(){
    if [ ! -f "$last_file" ]
    then
        scan_dir
        ls -l "$dir" > "$last_file"
    else
        ls -l "$dir" > "$new_file"

        if ! cmp -s "$last_file" "$new_file"
        then
            scan_dir
            ls -l "$dir" > "$last_file"
        fi
    fi
}


run_anti_virus
