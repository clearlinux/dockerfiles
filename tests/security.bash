# Defines helper functions used across a variety of tests.

#get container ID
# param 1, the image name
#get_container_id() {
#        if [ -n $1 ]; then
#	    local container_id=$(docker ps -a --format "table {{.ID}} {{.Image}}" | grep $1 | awk '{print $1}')
#            #echo $container_id
#        else
#            echo "Couldn't get container ID for image $1"
#        fi
#}

#Start security test
#SDL_T1207:Test that the 'on-failure' container restart policy is set to 5 (Docker)
Test_SDL_T1207() {
	if [ -n $1 ]; then
            local container_id=`docker ps -a --format "table {{.ID}} {{.Image}}" | grep $1 | awk '{print $1}'`
        else
            echo "Couldn't get container ID for image $1"
        fi
	local t1207=`docker ps --quiet --all | xargs docker inspect --format '{{ .Id }}: RestartPolicyName={{ .HostConfig.RestartPolicy.Name }} MaximumRetryCount={{ .HostConfig.RestartPolicy.MaximumRetryCount }}' | grep $container_id`
	local t1207_result=`echo $t1207 | awk -F":" '{print $2}'`
	local t1207_RestartPolicy=`echo $t1207_result | awk '{print $1}' | awk -F"=" '{print $2}'`
	local t1207_RetryCount=`echo $t1207_result | awk '{print $2}' | awk -F"=" '{print $2}'`
	if [ "$t1207_RestartPolicy" == "on-failure" ];then
        	if [ $t1207_RetryCount == "5" ];then
                	echo "pass"
        	fi
	else
        	echo "fail"
	fi
}

#SDL_T1191:Test if Linux Kernel Capabilities are restricted within containers (Docker)
Test_SDL_T1191() {
	if [ -n $1 ]; then
            local container_id=`docker ps -a --format "table {{.ID}} {{.Image}}" | grep $1 | awk '{print $1}'`
        else
            echo "Couldn't get container ID for image $1"
        fi
	local t1191=`docker ps --quiet --all | xargs docker inspect --format '{{ .Id }}: Privileged={{ .HostConfig.Privileged }}' | grep $container_id`
	#echo $t1191
	local t1191_result=`echo $t1191 | awk -F":" '{print $2}' | awk -F"=" '{print $2}'`
	if [ "$t1191_result" == "false" ];then
        	echo "pass"
	else
        	echo "fail"
	fi
}

#SDL_T1199:Test that the host's network namespace is not shared (Docker)
Test_SDL_T1199() {
        if [ -n $1 ]; then
            local container_id=`docker ps -a --format "table {{.ID}} {{.Image}}" | grep $1 | awk '{print $1}'`
        else
            echo "Couldn't get container ID for image $1"
        fi
	t1199=`docker ps --quiet --all | xargs docker inspect --format '{{ .Id }}: NetworkMode={{ .HostConfig.NetworkMode }}' | grep $container_id`
	#echo $t1199
	t1199_result=`echo $t1199 | awk -F":" '{print $2}' | awk -F"=" '{print $2}'`
	if [ "$t1199_result" == "host" ];then
        	echo "fail"
	else
        	echo "pass"
	fi
}

