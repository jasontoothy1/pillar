#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
clear
echo "Enter \"EXIT\" at ${red}Username ${reset}prompt to populate userlist and exit"
while x=0
do
  echo "${red}Username: ${reset}"
  read username
    if [ $username = "EXIT" ]
    then
      clear
      echo "user_list:" > /opt/pillar/base/user/init.sls
      cat /opt/pillar/base/user/cat/*txt >> /opt/pillar/base/user/init.sls
      exit 0
    else
  echo "${red}Password: ${reset}"
  read password
    firsthalf="python -c 'import crypt; print crypt.crypt(\""
    firsthalf+="$password"
    firsthalf+="\", \"\$6\$random_salt\")'"
    a="$firsthalf"
    echo $a > .a.sh
    lol=$(sh .a.sh)

  echo "${red}UID: ${reset}"
  read uid
  echo "${red}Full Name: ${reset}"
  read fullname
  echo "  $username:" > $username.txt

#  sd="sed \"/for j in/s/$/ "
#  sd+="\"$username\""
#  sd+="/\" /etc/salt/pwupdate.sh"
#  $sd
#  echo "$sd" > .b.sh
#  sh .b.sh
#  rm -rf .b.sh
  mkdir /etc/salt/users/"$username"
  echo "    passwd: $lol" >> $username.txt
  echo "    uid: $uid" >> $username.txt
  echo "    fullname: $fullname" >> $username.txt
  echo "  ${green}$username:"
  echo "    ${reset}passwd: $lol"
  echo "    uid: $uid"
  echo "    fullname: $fullname ${reset}"
  echo " "
  rm -rf .a.sh
  fi
done

