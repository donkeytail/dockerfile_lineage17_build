### docker container for redminote8 ginkgo lineageos build 

1 clone or download the code
2 make a docker image by dockerfile build
	`cd lineage_build_base/`
	`docker build -t lineage_build_base  .`
3 run the container with the command
	`docker run -v /c/work/android_device_xiaomi_ginkgo:/root/lineageos  -it lineage_build /bin/bash`
	
	
