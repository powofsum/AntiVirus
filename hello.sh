#! /usr/bin/bash
#this helps interpreter to knnow that this is bash script

echo "Hello world"


# #Systenm defined variables
# echo "$BASH_VERSION"  #shell version name
# echo $HOME
# echo $PWD  #PRESENT WORKING DIRECTORY

# #-----------------------------------

# #User defined variables
# name=Name
# echo The name is $name

# #-----------------------------------

# # read from user (inputs are in new line)
# echo "Enter name:"
# read name1 name2 name3
# echo "entered name :$name1 ,$name2 ,$name3"

# #-----------------------------------

# # read from user (input is in same line)
# read -p 'user name': 'user'
# read -sp 'password': 'pass'
# echo "name is $user"

# #-----------------------------------


# # read from user mutliple inputs(array)
# echo "Enter names :"
# read -a names
# echo "Names: ${names[0]}, ${names[1]}"

# #-----------------------------------

# # if read doesn't have variable it will automaticaly put in $REPLY
# echo "Enter name"
# read
# echo "Name: $REPLY"

# #-----------------------------------

# # args commands
# echo $1 $2 $3  ' > echo $1 $2 $3'
# args=("$@")    # $@ stores argument as array

# echo "$@"               #prints all args
# echo $#                 # print number of args

# #------------------------------------

# # if statement

# read -p 'usernum: ': 'num'

# if [ $num -eq 10 ]
#     then
#         echo "It's equal to 10"

#     elif [ $num -eq 9 ]
#         then
#         echo "It's equal to 9"

#     else
#         echo "It is not equal to 10"
    
# fi

# #-------------------------------------

# #file test operators

# echo -e "Enter name of file : \c"         #\c used to keep cursor on same line  (( -e used to enable \c ))
# read fileNmae

# if [ -d $fileNmae ]                           # -e file exist
#     then                                      # -f file exist and regular or not
#     echo "file/directory found"               # -d to check for directories
#     else                                      # -b block special file
#     echo "file/directory not found"           # -c character special
# fi                                            # -s checks if flag is empty ((true-> not empty ))

# #--------------------------------------

# # case statement

# echo -e "Enter: \c"
# read value

# case $value in
#     [a-z] )
#         echo "it is small" ;;
#     [A-Z] )
#         echo "it is capital" ;;         # if problem appear when typing capital letter , type LANG=C in terminal
#     [0-9] )
#         echo "it is number" ;;
#     ? )
#         echo " special one character" ;;
#     * )
#         echo "unknown input" ;;
# esac

# #---------------------------------------

# # WHILE LOOP

# n=1
# while [ $n -le 10 ]
# do
#     echo "$n"
#     ((n++))    # or n=$((n+1))   or((++n))
#     sleep 1
# done

##-----------------------------------------

# # read file content

# while read p
# do
#     echo"$p"
# done < hello.sh       #it will goes to parameter p
#  # ------or------
# cat hello.sh | while read p
# do  
#     echo "$p"
# done
# #-------or------
# while IFS= read -r p    #prevent \ escape from being treated as escape character
# do                      # empty space is being assigned to IFS 
#     echo"$p"
# done < hello.sh

##----------------------------------------

# #for loop
# echo ${BASH_VERSION}
# for i in {1..10..2}
# do  echo "$i"
# done
# #------or------
# for (( i=0;i<5;i++ ))
# do  
#     echo "$i"
# done

# # for loop to execute commands

# for command in ls pwd date    # in * means to loop over all files and directories
# do
#     echo "-------$command-------"
#     $command
# done


##----------------------------------------

# # break and continue statements
#  for (( i=0 ; i<10 ;i++))
#  do
#     if [ $i -gt 5 ]
#     then   
#         echo "$i"
#         break
#     fi
# done

##----------------------------------------

# functions
function hello(){
    echo "Hello $1"
}

hellov_2(){
    echo "Hellooooo"
}

hello user
hellov_2
