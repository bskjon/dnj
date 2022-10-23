#!/bin/bash

mkdir -p /usr/sbin/
mkdir -p /opt/java17

version=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/kyubisation/angular-server-side-configuration/releases/latest))

echo "Building with => " $TARGETARCH

if [[ $TARGETARCH == "arm"* ]] 
then 
    echo "Detected Target Arch ARM" $TARGETARCH >> /usr/sbin/ngssc.info
    printf "\nDownloading Ngssc\n"
    curl -L "https://github.com/bskjon/angular-server-side-configuration/releases/download/master/ngssc_arm_32bit" -o /usr/sbin/ngssc

else
    echo "Detected Target Arch x86_x64 (default)" $TARGETARCH >> /usr/sbin/ngssc.info
    printf "\nDownloading Ngssc\n"
    curl -L "https://github.com/kyubisation/angular-server-side-configuration/releases/download/$version/ngssc_64bit" -o /usr/sbin/ngssc

fi

chmod +x /usr/sbin/ngssc


if [[ $TARGETARCH == "arm"* ]] 
then 
    tar -xzf dep/java17-arm.tar.gz --strip-components=1 -C /opt/java17
else
    tar -xzf dep/java17-amd.tar.gz --strip-components=1 -C /opt/java17
fi


if [ -z "$(ls -A -- "/opt/java17")" ]; then
    printf "\n\nJava folder is empty!\n\n"
    printf "\nExiting now =>"
    exit 1
fi
chmod +x /opt/java17/bin/java

printf "\n\Setting default Java\n"
update-alternatives --install /usr/bin/java java /opt/java17/bin/java 100