#!/bin/bash  

# The following script is for committing, tagging and pushing code. 
# Once you git add, you can then run this and it will update the build-info and tag before pushing.

# Get latest release tag and store it
CURRTAG="$(git describe --tags `git rev-list --tags --max-count=1`)" 

# Get version from build-info.yml
VERSION="$(grep version build-info.yml | cut -d':' -f2 | sed 's/ //g')"
echo "Version from build-info.yml is $VERSION"

echo "Current git release is $CURRTAG"
# Remove "v" 
TAGNUMS=$(echo $CURRTAG | sed 's/v//')
# TAGNUMS="$(grep version build-info.yml | cut -d':' -f2 | sed 's/ //g')"

# Cut postion from "." delimited
MAJ="$(cut -d'.' -f1 <<<$TAGNUMS)"
MIN="$(cut -d'.' -f2 <<<$TAGNUMS)"
PAT="$(cut -d'.' -f3 <<<$TAGNUMS | cut -d'-' -f1)"
APPEND="$(cut -d'.' -f4 <<<$TAGNUMS | cut -d'-' -f1)"

#Select release type
echo "Select Release Type"
select release in Major Minor Patch RC Snapshot quit
do
    if [ "$release" != "" ]
        echo "Release Type Selected: $release"
        echo ""
    then
        break;
    fi
done

# Set new SemVer Version number
if [ "$release" == "Major" ]; then
    echo "Major update"
    NEWMAJ=$(($MAJ + 1))
    NEWMIN=0
    NEWPAT=0
fi

if [ "$release" == "Minor" ]; then
    echo "Minor update"
    NEWMAJ=$MAJ
    NEWMIN=$(($MIN + 1))
    NEWPAT=0
fi

if [ "$release" == "Patch" ]; then
    echo "Patch update or hotfix"
    NEWMAJ=$MAJ
    NEWMIN=$MIN
    NEWPAT=$(($PAT + 1))
fi

if [ "$release" == "Snapshot" ]; then
    echo "Release appendage is snapshot"
    ADDED="-snapshot" 
fi

if [ "$release" == "RC" ]; then
       echo "Release appendage is release candidate(rc)"
       APPTYPE="-rc."
    if [ -z "$APPEND" ]; then
        NEWAPPEND=1
    else
        NEWAPPEND=$(($APPEND + 1))
    fi

    ADDED="$APPTYPE$NEWAPPEND"
fi

# Set new Version Number
if [ -z "$ADDED" ]; then
   NEWVER=$(echo "v${NEWMAJ}.${NEWMIN}.${NEWPAT}")   
else
   NEWVER=$(echo "v${MAJ}.${MIN}.${PAT}${ADDED}") 
fi

echo "The build-info.yml version is $VERSION and the update is going to be to $NEWVER"

echo "Would you like to update build-info.yml from $VERSION to $NEWVER?"
select update in Yes No quit
do
    if [ "$update" == "Yes" ]; then
        echo "Updating build-info.yml"
        sed -i "s/version:.*/version: $NEWVER/g" build-info.yml
        git add build-info.yml
        break;
    else
        echo "Not updating build-info.yml"
        break;
    fi
done


echo "Enter a commit message:"
read message


echo "Commit message is: "$message" and tag is $NEWVER. Do you want to continue?" 
select confirm in Yes No quit
do
    if [ "$confirm" == "Yes" ]; then
        git commit -m "$message"
        git tag -a "$NEWVER" -m "$message"
        git push --follow-tags
        echo "Changes committed and Pushed"
        break;
    else
        echo "Changes not committed"
        exit;
    fi
done