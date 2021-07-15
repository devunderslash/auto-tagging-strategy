NAME 	:= devunderslash/tagpoc
TAG  	:= $$(git log -1 --pretty=%!H(MISSING))
IMG		:= ${NAME}:${TAG}
# LATEST	:= ${NAME}:LATEST

build:
  @docker build -t ${IMG} .
#   @docker tag ${IMG}
