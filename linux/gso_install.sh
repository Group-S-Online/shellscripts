#!/bin/sh


#the script will stop on the first error
#set -e


# store the current dir
CUR_DIR=$(pwd)

# copy credentials

echo "**************  \033[33mCOPY CREDENTIALS\033[0m";
cp -r /root/ssh /root/.ssh

# set up proxy 
echo "**************  \033[33mSETUP PROXY\033[0m";
export http_proxy="http://192.168.105.41:8080"
export https_proxy="http://192.168.105.41:8080"
export no_proxy="0.0.0.0,localhost,.groups.local,127.0.1.1,127.0.0.1,.groups.be"

# test if git is installed
echo "**************  \033[33mTEST IF GIT IS INSTALLED \033[0m";
if hash git  2>/dev/null; then

    echo "**************  \033[33mGIT: OK! \033[0m";
    # Clone repositories
    git clone git@git:presta-web-proxy
    git clone git@git:presta-web-i18n
    git clone git@git:presta-web-cdn
    git clone git@git:presta-hr-framework
    git clone git@git:presta-web-library
    git clone git@git:presta-web-login
    git clone git@git:presta-web-grunt
    git clone git@git:presta-web-home
    git clone git@git:presta-web-inbox
    git clone git@git:ipickup
#    git clone git@git:ipickup-mobile
    git clone git@git:icheckin
#    git clone git@git:dimona-mobile-mockup
    git clone git@git:whoiswho
    git clone git@git:icheckout
    git clone git@git:identity
    git clone git@git:iadmin
    git clone git@git:ireport
#    git clone git@git:dotfiles
    git clone git@git:inholidays 
    git clone git@git:hierarchy
    git clone git@git:transfer
    git clone git@git:transfer-online-be
    git clone git@git:transfer-online-fr
    git clone git@git:portal-cdn
    git clone git@git:portal-be
    git clone git@git:portal-fr



    ## PROXY
    echo "**************  \033[33mCREATING SYMLINKS FOR PRESTA-WEB-PROXY  \033[0m";
    cd presta-web-proxy/
    ln -s ../icheckin/public icheckin
    ln -s ../presta-web-cdn/public cdn
    ln -s ../presta-web-i18n/public i18n
    ln -s ../presta-web-grunt grunt
    ln -s ../presta-web-home/public home
    ln -s ../presta-web-inbox/public inbox
    ln -s ../presta-web-login/public login
    ln -s ../icheckout/public icheckout
    ln -s ../ireport/public ireport
    ln -s ../identity/public identity
    ln -s ../ipickup/public ipickup
    ln -s ../iadmin/public iadmin
    ln -s ../inholidays/public inholidays
    ln -s ../hierarchy/public hierarchy
    ln -s ../whoiswho/public whoiswho
    ln -s ../transfer/public transfer
    ln -s ../transfer-online-be/public transferbe
    ln -s ../transfer-online-fr/public transferfr
    ln -s ../portal-cdn/public portalcdn
    ln -s ../portal-be/public portalbe
    ln -s ../portal-fr/public portalfr
    
    
    echo "**************  \033[33mSETTING UP FRAMEWORK AND LIBRARY\033[0m";

    mkdir framework; cd framework
    ln -s ../../presta-hr-framework/public @@frameworkVersion@@; cd ..
    mkdir library; cd library
    ln -s ../../presta-web-library/public @@libraryVersion@@; cd ..


    echo "**************  \033[33mSETTING UP PORTAL-BE \033[0m";
    cd $CUR_DIR/portal-be;
    ln -s ../presta-web-i18n/public i18n;
    ln -s ../portal-cdn/public portalcdn;
    #ln -s ../presta-web-cdn/public/ cdn; 

    cd $CUR_DIR
    
    echo "**************  \033[33mTEST IF NPM IS INSTALLED \033[0m";
    if hash npm 2>/dev/null; then
        echo "**************  \033[33mNPM: OK! \033[0m";
        npm set registry http://nexustest.groups.local/content/groups/npm-all/
    else
        echo "xxxxxxxxxxx  \n\033[32mNODE IS NOT INSTALLED!!! xxxxxxxxxxx\033[0m\n"
        return 1;
    fi



    echo "\n\033[1m======= Executing command $@ for all repositories... =======\033[0m\n"

    # Find all git repositories and update it to the master latest revision
    for gitFolder in $(find . -maxdepth 4 -type d -name ".git" | cut -c 3-) ; do
    	echo "\033[1m**********************************************************";
    	echo "\033[1m######  \033[33m"+$gitFolder+"\033[0m";

        cd "$gitFolder";
        cd ..;

        #$@;
        ln -s ../presta-web-cdn/public/ cdn; 
        npm install;

        cd $CUR_DIR
    done

	echo "\n\033[1m======= PORTAL-BE SPECIFICS =======\033[0m\n"
	cd portal-be;
	node ./i18n/generate-i18n.js ./i18n/data ./public/parts


	echo "\n...___---===***^^^#### \033[32mComplete!\033[0m\n"

else 

    echo "***************  \n\033[32mGIT IS NOT INSTALLED!!!\033[0m\n"
fi
