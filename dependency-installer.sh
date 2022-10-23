#!/bin/bash

mkdir -p /usr/sbin/

version=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/kyubisation/angular-server-side-configuration/releases/latest))

if [[ $TARGETARCH == "arm"* ]] 
then 
    echo "Detected Target Arch ARM" $TARGETARCH >> /usr/sbin/ngssc.info
    curl -L "https://github.com/bskjon/angular-server-side-configuration/releases/download/master/ngssc_arm_32bit" -o /usr/sbin/ngssc
   # curl -L "https://github.com/kyubisation/angular-server-side-configuration/releases/download/$version/ngssc_32bit" -o /usr/sbin/ngssc
else
    echo "Default x86_x64" $TARGETARCH >> /usr/sbin/ngssc.info
    curl -L "https://github.com/kyubisation/angular-server-side-configuration/releases/download/$version/ngssc_64bit" -o /usr/sbin/ngssc
fi

chmod +x /usr/sbin/ngssc


if [[ $TARGETARCH == "arm"* ]] 
then 
    curl -L https://cdn.azul.com/zulu-embedded/bin/zulu17.38.21-ca-jre17.0.5-linux_aarch32hf.tar.gz -o java.tar.gz
else
    curl -L https://cdn.azul.com/zulu/bin/zulu17.38.21-ca-jre17.0.5-linux_x64.tar.gz -o java.tar.gz
fi

mkdir -p /opt/java17
tar -xzvf ./java.tar.gz --strip-components=1 -C /opt/java17
chmod +x /opt/java17/bin/java

update-alternatives --install /usr/bin/java java /opt/java17/bin/java 100
rm ./java.tar.gz