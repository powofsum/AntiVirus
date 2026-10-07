#! /usr/bin/bash

dir="$1"
malicious_dir="$2"
source ./virusdetection.sh


# ----- FUNCTIONS---------

restore_file(){
    # if virus_detected "${files[$number -1]}"
    # then
    #     echo "Can't be restored. File contains virus"
    # else
        if mv -i "$malicious_dir/${files[$number -1]}" "$dir"
        then echo "Restored ${files[$number-1]} to $dir "
        else
            echo "Error occured"

        fi
    # fi
}

delete_permanently(){
    if rm -i "$malicious_dir/$file_selected"
    then    
        echo "$file_selected permanently deleted"
    fi  
}





#-------------------------


while true
do
    if [ -z "$(ls "$malicious_dir")" ]
    then
        echo "No malicious files to review"
        break
    else
        echo "-------Files-------"
        ls "$malicious_dir" | nl

        mapfile -t files < <(ls "$malicious_dir")


        echo -e "Pick one of the files \c"
        read number

        echo "Input 1 : Restore file back to dir"
        echo "Input 2 : Permenantly delete this file from malicious_dir"
        echo "Input 3 : Leave this file as it is and go back to the list"
        read choice

        file_selected=${files[$number -1]}


        if [[ "$choice" -eq 1 ]]
        then
            restore_file

        elif [[ "$choice" -eq 2 ]]
        then
            delete_permanently

        elif [[ "$choice" -eq 3 ]]
        then
            
            continue

        else
            echo "Invalid choice"
        fi
        


        #CHECK INVALID INPUTS


    fi
done