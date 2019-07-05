FROM ubuntu:16.04
USER root

RUN apt-get update
RUN apt-get install -y python-pip  git openssh-client openssh-server sshpass
RUN pip install --upgrade pip
RUN apt-get update;apt-get install curl -y
RUN apt-get install groff -y


#AWS
RUN pip install pydblite==3.0.4 
RUN pip install awscli==1.11.178


#AZURE
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN echo "#!/bin/bash" >> /azure_cli_executor.sh
RUN echo "az login -u \$AZURE_USER_NAME -p \$AZURE_PASSWORD > /dev/null 2>&1;\n" >> /azure_cli_executor.sh
RUN echo "az \"\$@\"\n" >> /azure_cli_executor.sh
RUN echo "az logout\n" >> /azure_cli_executor.sh

RUN chmod +x /azure_cli_executor.sh




#GCLOUD
RUN apt-get update;apt-get install curl -y
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud
RUN tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz
RUN /usr/local/gcloud/google-cloud-sdk/install.sh
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
RUN mkdir -p /root/.config/gcloud




#ALIBABA CLOUD
RUN curl http://aliyuncli.alicdn.com/aliyun-cli-linux-3.0.19-amd64.tgz --output /tmp/aliyun.tgz
RUN mkdir -p /usr/local/aliyun
RUN tar -C /usr/local/aliyun -xvf /tmp/aliyun.tgz
ENV PATH $PATH:/usr/local/aliyun
	