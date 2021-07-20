# Release POC
This repo is a proof of concept for the initial stages of CI/CD and an attempt at tackling some of the challenges with maintaining Long Term branched projects.

## Auto tag

The `auto-tag-commit.sh` script will automatically tag the current commit with the current version number. It will also update the build-info.yml with the the next semver version number. The main component of the code is the ability to auto tag, commit and push the code with the most up to date version number as determined by the build-info.yml version.

The main pieces of code that are useful for long term branches from that script are:

``` 
 # Get version from build-info.yml
 VERSION="$(grep version build-info.yml | cut -d':' -f2 | sed 's/ //g')"

 git tag -a "$VERSION" -m "$message"
 git push --follow-tags 
 ```

The above code (--follow-tags) allows us to tag on a feature branch outside of the release branch and upon merge the tag will also be merged allowing us to drive our pipeline based on the release tag. 

## Cascading / Ripple merge

The `auto-merge.sh` script wiil run a cascading merge from the oldest branch (release-1) to the newest branch (release-3) and then into master. This was to test how hotfixes can be automated to update each branch in a cascading fashion. This will reduce the need for this to be carried out manually and also in turn reduce the possibility of human error.

## Auto tagging docker images

The `docker-build.sh` script will automatically tag a docker image with the commit hash and timestmp. This is to help with the automated build of docker images.

### Tagging docker images experimentation
To Build the dockerfile use the following:

Run the bash script with `sh docker-build.sh`

To run the image:

`docker run -it -d --name {enter-name-here} -p 80:8080 devunderslash/test:{hash}-{timestamp}` 

You can get the {hash}-{timestamp} from running `docker ps`

If you want to get into the container then run the following:

`docker exec -it {container-name} bash`
