#! /usr/bin/bash 


dir="$1"
malicious_dir="$2"
interval_secs="$3"


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

scan_dir(){
    
for file in "$dir"/*
do
    if [ -f "$file" ]
    then
        if virus_detected "$file"
        then
            # ls -l "$dir" > directory-info.last
            echo "$file is malicious and it is DELETED"
            # DELTE AND MOVE IT TO MALICIOUS DIR
            move_to_malicious_dir "$file"
            #echo "$file"
        # else
            # echo "no virus"
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
        mv -i "$1" "$distDIR"  # I FLAG
        # echo " $file is virus"

    fi
}


run_anti_virus(){
    scan_dir
     ls -l "$dir" > directory-info.last
     sleep "$interval_secs"
     

    while true
    do  
        ls -l "$dir" > directory-info.new
        if cmp -s "directory-info.last" "directory-info.new"
        then
            sleep "$interval_secs"
        else
            scan_dir
            # cp directory-info.new directory-info.last
            ls -l "$dir" > directory-info.last
            # break
        fi
    done
}

run_anti_virus

