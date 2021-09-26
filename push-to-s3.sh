#!/bin/bash
###############################################################################
#                                                                             #
# this mac/linux script  pushes the latest deployers up to S3                 #
# ready for the one click launch buttons                                      #
#                                                                             #
# Simon Green                                                                 #
#                                                                             #
###############################################################################
S3BucketName="contrail-one-click-deployers"
AWSAZ="eu-central-1"
PathForTheDeployers="./deployers/"

echo "*******************************************************************************"
echo "This script is for the admins, you do not need to run it."
echo "It creates a public s3 bucket if needed then pushed up the latest version on the deployers to it"
echo "Its used by the one click launch buttons on the wiki page."
echo "You can also take the button code and embed it in your own sites"
echo "*******************************************************************************"
echo "ok lets get started..."
echo -n "Are you an admin on the SRE aws account and want to push up the latest deployer to S3?"
read -p "$* [y/n] " areyoureallytheadmin 
if [ $areyoureallytheadmin == "y" ] ||  [ $areyoureallytheadmin == "Y" ] ;
then
        echo "ok then lets proceed..."
else
        echo "This is an admin tool existing"
        exit 0
fi

#Check you can reach aws and list the existing S3 buckets
BucketList=`aws s3 ls`
if [ $? -ne 0 ];then
  echo "It doent look like you are connected to AWS, exiting!"
  exit 0 
fi

#check for the bucket name
BucketList=`aws s3 ls`
if [[ $BucketList =~ $S3BucketName ]]; then
  echo "The bucket already exists so we will not recreate it"
else
  echo "Creating the s3 bucket"
  aws s3 mb s3://$S3BucketName --region $AWSAZ 
fi

#copy the json files over to the bucket
aws s3 sync $PathForTheDeployers s3://$S3BucketName --acl public-read

printf "************************************\n"
printf "\nYour launch stack url's will be\n" 
printf "************************************\n"
for i in `ls $PathForTheDeployers/` 
do
  BaseName=`echo $i | cut -d'.' -f1`
  printf "https://console.aws.amazon.com/cloudformation/home?region=%s#/stacks/new?stackName=%s&templateURL=https://s3-${AWSAZ}.amazonaws.com/%s/%s\n" $AWSAZ $BaseName $S3BucketName $i 
done
printf "************************************\n"

