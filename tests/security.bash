# Defines helper functions used across a variety of tests.

#Start security test
#SDL_T1191:Test if Linux Kernel Capabilities are restricted within containers (Docker)
Test_SDL_T1191() {
	if [ -n $1 ]; then
            local container_id=`docker ps --format "table {{.ID}} {{.Image}}" | grep $1 | awk '{print $1}'`
        else
            echo "Couldn't get container ID for image $1"
        fi
	local t1191=`docker ps --quiet --all | xargs docker inspect --format '{{ .Id }}: Privileged={{ .HostConfig.Privileged }}' | grep $container_id`
	local t1191_result=`echo $t1191 | awk -F"=" '{print $2}'`
	if [ "$t1191_result" == "false" ];then
        	echo "pass"
	else
        	echo "fail"
	fi
}

#SDL_T1195: Test if SSH is running within containers (Docker)
Test_SDL_T1195() {
	if [ -n $1 ]; then
            local container_id=`docker ps --format "table {{.ID}} {{.Image}}" | grep $1 | awk '{print $1}'`
        else
            echo "Couldn't get container ID for image $1"
        fi
	t1195=`docker exec $container_id ps -el | grep -i ssh`
	if [ "$t1195" == "" ];then
		echo "pass"
	else
		echo "fail"
	fi
}

#SDL_T1215: Verify that containers are restricted from acquiring additional privileges (Docker)
Test_SDL_T1215() {
	if [ -n $1 ]; then
            local container_id=`docker ps --format "table {{.ID}} {{.Image}}" | grep $1 | awk '{print $1}'`
        else
            echo "Couldn't get container ID for image $1"
        fi
	t1215=`docker ps --quiet --all | xargs docker inspect --format '{{ .Id }}: SecurityOpt={{ .HostConfig.SecurityOpt }}' | grep $container_id`
	t1215_result=`echo $t1215 | awk -F"=" '{print $2}'`
	if [ "$t1215_result" == "[no-new-privileges]" ];then
		echo "pass"
	else
		echo "fail"
	fi
}


