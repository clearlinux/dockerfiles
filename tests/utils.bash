# Defines helper functions used across a variety of tests.

check_os() {
    os="unknown"
    if [ -f "/etc/os-release" ]; then
        local os_name=$(cat /etc/os-release)
        if [[ $os_name =~ "Clear Linux" ]]; then
            os="clearlinux"
        elif [[ $os_name =~ "Ubuntu" ]]; then
            os="ubuntu"
        elif [[ $os_name =~ "CentOS" ]]; then
            os="centos"
        else
            os="unknown"
        fi
    fi

    echo $os
}

# check container status 
# if no paramter passed, check the latest created docntainer
# otherwise, check the container name as the parameter
check_container_status() {
    if [ -n $1 ]; then
        sudo docker ps | grep $1 | grep Up
    else
        sudo docker ps -l | grep Up
    fi
}

# get container IP address
# param 1, the container name
get_container_ip() {
    if [ -n $1 ]; then
        local ipaddr=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)
        echo $ipaddr
    else
        echo "Couldn't get IP address for container $1"
        false
    fi
}
