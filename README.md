I have come up with a solution where we can have aws,azure,gcloud and aliyun cloud CLI in one Docker image. This reduces the hassle of installing individual cloud CLI binary on the workstation/laptop. 


How to use it
1. Install Docker 
2. Pull the docker image from `docker pull raghumbalgi84/multi_cloud_cli_image`
3. To run the CLI command you need to first download and place individual cloud shell scripts file in it into your path `/usr/local/bin/` directory. This file basically run the docker image and brings up the container to run cli command on it.
	Run below commands to achieve step 3

		curl -o /usr/local/bin/aws https://raw.githubusercontent.com/raghavendrabalgi/multi_cloud_cli/master/aws && chmod a+x /usr/local/bin/aws

		curl -o /usr/local/bin/az https://raw.githubusercontent.com/raghavendrabalgi/multi_cloud_cli/master/az && chmod a+x /usr/local/bin/az

		curl -o /usr/local/bin/gcloud https://raw.githubusercontent.com/raghavendrabalgi/multi_cloud_cli/master/gcloud && chmod a+x /usr/local/bin/gcloud

		curl -o /usr/local/bin/aliyun https://raw.githubusercontent.com/raghavendrabalgi/multi_cloud_cli/master/aliyu && chmod a+x /usr/local/bin/aliyun



4. To run aws cli commands create below environment variable with your account keys.You can have these env varibales in `~/.bash_profile` or ` ~/.bashrc` to have it permanently and available anytime.
      	        
		export AWS_ACCESS_KEY_ID="<id>"
		export AWS_SECRET_ACCESS_KEY="<key>"
		export AWS_DEFAULT_REGION="<region>"

    Run aws command as below 
		
		REMXYZ:multi_cloud_cli newuser$ aws s3 ls
		2019-05-03 11:50:10 08-86-pxyz
		2019-03-13 05:46:09 abcd-new

5. To run aliyun cli commands create below environment variable with your account keys.You can have these env varibales in `~/.bash_profile` or ` ~/.bashrc` to have it permanently and available anytime.

		export ALI_ACCESS_KEY="<abcd>"
		export ALI_ACCESS_SECRET="<xyz>"
		export ALI_DEFAULT_REGION="<some-region>”

	Run aliyun command as below 
		
		REMXYZ:multi_cloud_cli newuser$ aliyun ecs DescribeRegions


6. To run azure cli commands create below environment variable  as with your account username/pwd.You can have these env varibales in `~/.bash_profile` or ` ~/.bashrc` to have it permanently and available anytime.
	
		export AZURE_USER_NAME="<xyz>"
		export AZURE_PASSWORD="<abc>"

	Run azure command as below
	   
	   REMXYZ:multi_cloud_cli newuser$ az vm list
		[			
  
    		"additionalCapabilities": null,
    		"availabilitySet": null,
    		"diagnosticsProfile": {
     		 "bootDiagnostics": {
    		  "enabled": true,
       		 "storageUri": "https://abcd1234.blob.core.windows.net/"
      
    	},
    	"hardwareProfile": {
     	 "vmSize": "Standard_A2_v2"
		…..

7. To run gcloud cli , you need to configure it first, once configured the settings are persisted through volume mount with host system and whenever docker container comes up it uses the persisted account information to execute the CLI command

		REMXYZ:multi_cloud_cli newuser$ gcloud init
			Welcome! This command will take you through the configuration of gcloud.

	Run gcloud command as below 
			
			REMXYZ:multi_cloud_cli newuser$ gcloud compute instances list
			NAME  ZONE  MACHINE_TYPE PREEMPTIBLE  INTERNAL_IP    EXTERNAL_IP      STATUS
			test_instance  asia-east1-a   n1-standard-110.10.10.20 2.2.2.2        RUNNING







