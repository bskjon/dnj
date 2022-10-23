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

    printf "\n\nDownloading Java\n"
    wget -q -O /java.tar.gz "https://cdn.azul.com/zulu-embedded/bin/zulu17.38.21-ca-jre17.0.5-linux_aarch32hf.tar.gz"

else
    echo "Detected Target Arch x86_x64 (default)" $TARGETARCH >> /usr/sbin/ngssc.info
    printf "\nDownloading Ngssc\n"
    curl -L "https://github.com/kyubisation/angular-server-side-configuration/releases/download/$version/ngssc_64bit" -o /usr/sbin/ngssc

    printf "\n\nDownloading Java\n"
    wget -q -O /java.tar.gz "https://cdn.azul.com/zulu/bin/zulu17.38.21-ca-jre17.0.5-linux_x64.tar.gz"
fi

chmod +x /usr/sbin/ngssc

tar -xzf /java.tar.gz --strip-components=1 -C /opt/java17

if [ -z "$(ls -A -- "/opt/java17")" ]; then
    printf "\n\nJava folder is empty!\n\n"
    printf "\nExiting now =>"
    exit 1
fi
chmod +x /opt/java17/bin/java

printf "\n\Setting default Java\n"
update-alternatives --install /usr/bin/java java /opt/java17/bin/java 100