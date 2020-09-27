# docker container for lineage-17.1 build

1. clone or download the code
2. make a docker image by dockerfile build (you shoul set the ARGS)
	- `cd lineage_build_base/`
	- `docker build --build-arg USER_EMAIL="xxxxx@xxx" --build-arg USER_NAME="xxxxx" -t lineage_build_base .`
3. run the container with the command
	- `docker run -v /c/work/android_device_xiaomi_ginkgo:/root/lineageos  -it lineage_build /bin/bash`
	
	
