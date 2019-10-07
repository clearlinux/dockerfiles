## Data Analytics Reference Stack with OpenBLAS

[![](https://images.microbadger.com/badges/image/clearlinux/stacks-dars-openblas.svg)](http://microbadger.com/images/clearlinux/stacks-dars-openblas "Get your own image badge on microbadger.com")

### Building Locally

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

```bash
docker build --no-cache -t clearlinux/stacks-dars-openblas .
```

### Build ARGs

* `swupd_args` specifies [swupd update](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags passed to the update during build.

>NOTE: An empty `swupd_args` will default to Clear Linux OS latest version. Consider this when building from the Dockerfile, as an OS update will be performed. The docker image in this registry was built and validated using version `30970`.

### Running a DARS Container

To run a container you must know the name of the image or hash of the image. The name is `clearlinux/stacks-dars-openblas` for MKL-based image.
The hash can be retrieved along with all imported images with the command:

```bash
docker images
```

Now that you know the name of the image, you can run it:

```bash
docker run --ulimit nofile=1000000:1000000 --name <container name> --network host --rm -i -t clearlinux/stacks-dars-openblas
```

or if you need to provide volume mappings as per your machines directory paths:

```bash
docker run --ulimit nofile=1000000:1000000 --name <container name> -v /data/datad:/mnt/disk1/dars/oblas -v /data/datae:/mnt/disk2/dars/oblas --network host --rm -i -t clearlinux/stacks-dars-openblas
```

Please note that `/data/datad` and `/data/datae` are directories on the host machine while `/mnt/disk1/dars/mkl`, `/mnt/disk2/dars/oblas` are the mount points inside the container in the form of directories and are created on demand if they do not exist yet.
Also, for simplicity we provided --network as host, so host machine IP itself can be used to access container.

The extra `--ulimit nofile` parameter is currently required in order to increase the
number of open files opened at certain point by the spark engine.

## Java Requirements

All of the DARS components are compiled on Open JDK11. Container will have preinstalled JDK11 at /usr/lib/jvm/java-1.11.0-openjdk/ and it has been set as the default java version.
It is worth mentioning that the containers also contain Open JDK8, but we won't needed on this setup.

### **NOTE**

>Since Clear Linux OS is a stateless system, you should never modify the files under the `/usr/share/defaults` directory. The software updater will overwrite those files.

***

>In the Dockerfile it's been configured the most common environment variables for you.
For Apache Hadoop use `/etc/hadoop` as `HADOOP_CONF_DIR` folder.
For Apache Spark use `/etc/spark` as `SPARK_CONF_DIR` folder.

***

## Single Node Hadoop Cluster Setup

In this mode, all the daemons involved i.e. The DataNode, NameNode, TaskTracker and JobTracker run as Java processes on the same machine. This setup is useful for developing and testing Hadoop applications.

The components of a Hadoop Cluster are described below:

- **NameNode:** Manages HDFS storage. HDFS exposes a filesystem namespace and allows user data to be stored in files. Internally a file is split into one or more blocks and these blocks are stored in a set of DataNodes.
  We will indicate that the NameNode runs in our localhost. Follow these steps to set it up correctly:

- **DataNode:** is also known as Slave node, it is responsible for storing and managing the data in that node and responds to the NameNode for all filesystem operations.

- **JobTracker:** is a master which creates and runs the job through tasktrackers. It also tracks resource availability and task lifecycle management.

- **TaskTracker:** Manage the processing resources on each worker node and send status updates to the JobTracker periodically.

### Configuration

To setup a single node cluster we need to run a container from stacks-dars-openblas image:

```bash
docker run --ulimit nofile=1000000:1000000 -ti --rm --network host clearlinux/stacks-dars-openblas
cp -r -n /usr/share/defaults/hadoop/* /etc/hadoop
```

## Inside the running container we need to edit hadoop configuration files as follows

`/etc/hadoop/mapred-site.xml`:

```bash
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>

    <property>
        <name>yarn.app.mapreduce.am.env</name>
        <value>HADOOP_MAPRED_HOME=${HADOOP_HOME}</value>
    </property>

    <property>
        <name>mapreduce.map.env</name>
        <value>HADOOP_MAPRED_HOME=${HADOOP_HOME}</value>
    </property>

    <property>
        <name>mapreduce.reduce.env</name>
        <value>HADOOP_MAPRED_HOME=${HADOOP_HOME}</value>
    </property>
</configuration>
```

`/etc/hadoop/yarn-site.xml`:

```bash
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <property>
        <name>yarn.nodemanager.auxservices.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
</configuration>
```

## Start Hadoop daemons

1. Format the NameNode server using the following command:

```bash
hdfs namenode -format
```

2. **Start Hadoop services** as indicated below:

To start HDFS Namenode service          :

```bash
hdfs --daemon start namenode
```

To start HDFS Datanode service          :

```bash
hdfs --daemon start datanode
```

To start Yarn ResourceManager           :

```bash
yarn --daemon start resourcemanager
```

To start Yarn NodeManager               :

```bash
yarn --daemon start nodemanager
```

To start jobhistory service             :

```bash
mapred --daemon start historyserver
```

3. Verify the alive node(s) using the following command:

```bash
yarn node -list 2
```

Your output will look like:

```bash
Total Nodes:1
         Node-Id             Node-State Node-Http-Address       Number-of-Running-Containers
    <hostname>:43489            RUNNING <hostname>:8042                      0
```

### Run an example

Run the Pi Calculator Example on Hadoop

Hadoop comes packaged with a set of example applications. In the next example we will show how to use Hadoop to calculate Pi number.
The JAR file containing the compiled class can be found on your running DARS container at: `/usr/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.0.jar`

```bash
hadoop jar /usr/share/hadoop/mapreduce/hadoop-mapreduce-examples-$(hadoop version | grep Hadoop | cut -d ' ' -f2).jar pi 16 100
```

If the program runs correctly, you should see output similar to the following:

```bash
Estimated value of Pi is 3.14159125000000000000
```

***

## Single Node Spark Cluster Setup

### Start the master server and a worker daemons

1. Start the master server using:

```bash
/usr/share/apache-spark/sbin/start-master.sh
```

2. Start the worker daemon and connect it to the master:

```bash
/usr/share/apache-spark/sbin/start-slave.sh spark://$(hostname):7077
```

3. You can open an internet browser to monitor and inspect Spark job executions. The web UI is available at the master’s IP address and port 8080:

```bash
http://hostname:8080
```

### Run an example

Run the Pi Calculator Example on Spark

```bash
spark-submit --class org.apache.spark.examples.SparkPi --master spark://$(hostname):7077 --deploy-mode client /usr/share/apache-spark/examples/jars/spark-examples_2.12-$(cat /usr/share/apache-spark/RELEASE | grep Spark | cut -d ' ' -f2).jar 100
```

If the program runs correctly, you should see output similar to the following:

```bash
Pi is roughly 3.1413871141387113

```

***

## Run the Pi Calculator Example on spark-shell

```bash
root@86dafb0d7521~ $ spark-shell --conf "spark.hadoop.fs.defaultFS=file:///"
```

```bash
scala> import scala.math.random
import org.apache.spark._
val conf = new SparkConf().setAppName("Spark Pi")
val sc = new SparkContext(conf)
val slices = 5
val n = math.min(100000L * slices, Int.MaxValue).toInt
val xs = 1 until n
val rdd = sc.parallelize(xs, slices).setName("'Initial rdd'")
val sample = rdd.map { i =>
val x = random * 2 - 1
val y = random * 2 - 1
(x, y)
}.setName("'Random points sample'")

val inside = sample.filter { case (x, y) => (x * x + y * y < 1) }.setName("'Random points inside circle'")
val count = inside.count()
println("Pi is roughly " + 4.0 * count / n)
sc.stop()
```

***

## Run the Pi Calculator Example on pyspark

```bash
root@86dafb0d7521~ $ pyspark --conf "spark.hadoop.fs.defaultFS=file:///"
```

```bash
>>> import random
NUM_SAMPLES = 100000000
def inside(p):
    x, y = random.random(), random.random()
    return x*x + y*y < 1

count = sc.parallelize(range(0, NUM_SAMPLES)).filter(inside).count()
print ("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
```

***

## Deploy DARS on Kubernetes

Many containerized workloads are deployed in clusters and orchestration software like Kubernetes, for this purpose it is provided a Dockerfile and an entrypoint script.

### Prerequisites

* A running Kubernetes cluster at version >= 1.6 with access configured to it using kubectl.
* You must have appropriate permissions to list, create, edit and delete pods in your cluster.
* The service account credentials used by the driver pods must be allowed to create pods, services and configmaps.
* You must have Kubernetes DNS configured in your cluster.

1. For this will example use the following `Dockerfile`. Execute the following to create the file.

```bash
cat > $(pwd)/Dockerfile << 'EOF'
ARG DERIVED_IMAGE
FROM ${DERIVED_IMAGE}

RUN mkdir -p /etc/passwd /etc/pam.d /opt/spark/conf /opt/spark/work-dir

RUN set -ex && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    touch /etc/pam.d/su \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd

RUN ln -s /usr/share/apache-spark/jars/ /opt/spark/ && \
    ln -s /usr/share/apache-spark/bin/ /opt/spark/ && \
    ln -s /usr/share/apache-spark/sbin/ /opt/spark/ && \
    ln -s /usr/share/apache-spark/examples/ /opt/spark/ && \
    ln -s /usr/share/apache-spark/kubernetes/tests/ /opt/spark/ && \
    ln -s /usr/share/apache-spark/data/ /opt/spark/ && \
    ln -s /etc/spark/* /opt/spark/conf/

COPY entrypoint.sh /opt/
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV SPARK_HOME /opt/spark
WORKDIR /opt/spark/work-dir
ENTRYPOINT [ "/opt/entrypoint.sh" ]
EOF
```

2. The Dockerfile require an entrypoint script, this allows to `spark-submit` interact with the container using given arguments. Create the `entrypoint.sh` file.

```bash
cat > $(pwd)/entrypoint.sh << 'EOF'
#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# echo commands to the terminal output
set -ex

# Check whether there is a passwd entry for the container UID
myuid=$(id -u)
mygid=$(id -g)
# turn off -e for getent because it will return error code in anonymous uid case
set +e
uidentry=$(getent passwd $myuid)
set -e

# If there is no passwd entry for the container UID, attempt to create one
if [ -z "$uidentry" ] ; then
    if [ -w /etc/passwd ] ; then
        echo "$myuid:x:$myuid:$mygid:anonymous uid:$SPARK_HOME:/bin/false" >> /etc/passwd
    else
        echo "Container ENTRYPOINT failed to add passwd entry for anonymous UID"
    fi
fi

SPARK_K8S_CMD="$1"
case "$SPARK_K8S_CMD" in
    driver | driver-py | driver-r | executor)
      shift 1
      ;;
    "")
      ;;
    *)
      echo "Non-spark-on-k8s command provided, proceeding in pass-through mode..."
      exec /sbin/tini -s -- "$@"
      ;;
esac

SPARK_CLASSPATH="$SPARK_CLASSPATH:${SPARK_HOME}/jars/*"
env | grep SPARK_JAVA_OPT_ | sort -t_ -k4 -n | sed 's/[^=]*=\(.*\)/\1/g' > /tmp/java_opts.txt
readarray -t SPARK_EXECUTOR_JAVA_OPTS < /tmp/java_opts.txt

if [ -n "$SPARK_EXTRA_CLASSPATH" ]; then
  SPARK_CLASSPATH="$SPARK_CLASSPATH:$SPARK_EXTRA_CLASSPATH"
fi

if [ -n "$PYSPARK_FILES" ]; then
    PYTHONPATH="$PYTHONPATH:$PYSPARK_FILES"
fi

PYSPARK_ARGS=""
if [ -n "$PYSPARK_APP_ARGS" ]; then
    PYSPARK_ARGS="$PYSPARK_APP_ARGS"
fi

R_ARGS=""
if [ -n "$R_APP_ARGS" ]; then
    R_ARGS="$R_APP_ARGS"
fi

if [ "$PYSPARK_MAJOR_PYTHON_VERSION" == "2" ]; then
    pyv="$(python -V 2>&1)"
    export PYTHON_VERSION="${pyv:7}"
    export PYSPARK_PYTHON="python"
    export PYSPARK_DRIVER_PYTHON="python"
elif [ "$PYSPARK_MAJOR_PYTHON_VERSION" == "3" ]; then
    pyv3="$(python3 -V 2>&1)"
    export PYTHON_VERSION="${pyv3:7}"
    export PYSPARK_PYTHON="python3"
    export PYSPARK_DRIVER_PYTHON="python3"
fi

case "$SPARK_K8S_CMD" in
  driver)
    CMD=(
      "$SPARK_HOME/bin/spark-submit"
      --conf "spark.driver.bindAddress=$SPARK_DRIVER_BIND_ADDRESS"
      --deploy-mode client
      "$@"
    )
    ;;
  driver-py)
    CMD=(
      "$SPARK_HOME/bin/spark-submit"
      --conf "spark.driver.bindAddress=$SPARK_DRIVER_BIND_ADDRESS"
      --deploy-mode client
      "$@" $PYSPARK_PRIMARY $PYSPARK_ARGS
    )
    ;;
    driver-r)
    CMD=(
      "$SPARK_HOME/bin/spark-submit"
      --conf "spark.driver.bindAddress=$SPARK_DRIVER_BIND_ADDRESS"
      --deploy-mode client
      "$@" $R_PRIMARY $R_ARGS
    )
    ;;
  executor)
    CMD=(
      ${JAVA_HOME}/bin/java
      "${SPARK_EXECUTOR_JAVA_OPTS[@]}"
      -Xms$SPARK_EXECUTOR_MEMORY
      -Xmx$SPARK_EXECUTOR_MEMORY
      -cp "$SPARK_CLASSPATH"
      org.apache.spark.executor.CoarseGrainedExecutorBackend
      --driver-url $SPARK_DRIVER_URL
      --executor-id $SPARK_EXECUTOR_ID
      --cores $SPARK_EXECUTOR_CORES
      --app-id $SPARK_APPLICATION_ID
      --hostname $SPARK_EXECUTOR_POD_IP
    )
    ;;

  *)
    echo "Unknown command: $SPARK_K8S_CMD" 1>&2
    exit 1
esac

# Execute the container CMD
exec "${CMD[@]}"
EOF
```

3. Give execute permission to `entrypoint.sh` script.

```bash
sudo chmod +x $(pwd)/entrypoint.sh
```

4. Build Image, for this example use `dars_k8s_spark` as name.

```bash
docker build . --build-arg DERIVED_IMAGE=clearlinux/stacks-dars-openblas -t dars_k8s_spark
```

5. Verify your built image. Execute the following command looking for the given name `dars_k8s_spark`

```bash
docker images | grep "dars_k8s_spark"
```

You should see something like:

```bash
dars_k8s_spark                               latest              1fa3278a3421        1 minutes ago       6.56GB
```

6. Use a variable to store the image's given name:

```bash
DARS_K8S_IMAGE=dars_k8s_spark
```

### Configure RBAC

1. Create the spark service account and cluster role binding to allow Spark on Kubernetes create Executors as required. In this example use the `default` namespace.

```bash
kubectl create serviceaccount spark-serviceaccount --namespace default
kubectl create clusterrolebinding spark-rolebinding --clusterrole=edit --serviceaccount=default:spark-serviceaccount --namespace=default
```

### Prepare to Submit Spark Job

1. Determine the Kubernetes master address:

```bash
kubectl cluster-info
```

You should see something like:

```bash
Kubernetes master is running at https://192.168.39.127:8443
```

2. Use a variable to store the master address:

```bash
MASTER_ADDRESS='https://192.168.39.127:8443'
```

### Submit Spark Job on Minikube

1. Execute following command using `MASTER_ADDRESS` and `DARS_K8S` variables. Driver pod will be called `spark-pi-driver`.

More information about `spark-submit` configuration on [running-on-kubernetes documentation](https://spark.apache.org/docs/latest/running-on-kubernetes.html#configuration).

```bash
spark-submit \
--master k8s://${MASTER_ADDRESS} \
--deploy-mode cluster \
--name spark-pi \
--class org.apache.spark.examples.SparkPi \
--conf spark.executor.instances=2 \
--conf spark.kubernetes.container.image=${DARS_K8S_IMAGE} \
--conf spark.kubernetes.driver.pod.name=spark-pi-driver \
--conf spark.kubernetes.namespace=default \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-serviceaccount \
local:///usr/share/apache-spark/examples/jars/spark-examples_2.12-2.4.0.jar
```

2. Check the Job. Read the logs and look for the Pi result:

```bash
kubectl logs spark-pi-driver | grep "Pi is roughly"
```

You should see something like:

```bash
Pi is roughly 3.1418957094785473
```

***

## Kubernetes installation

To install Kubernetes in Clear Linux, follow the instructions in the Clear Linux's [Kubernetes Tutorial](https://docs.01.org/clearlinux/latest/tutorials/kubernetes.html)

## **FAQ**

* Pyspark / Spark-shell drops `connection exception` or `Connection refused` this happens due HADOOP_CONF_DIR environment variable is set and these APIs are assuming will use Hadoop Distributed File System.
You can `unset HADOOP_CONF_DIR` and use Spark RDD, or start Hadoop services and then create your directories and files as you required using `hdfs`.

Also it is possible to change the file system to local without `unset HADOOP_CONF_DIR` as is further described below:

```bash
pyspark --conf "spark.hadoop.fs.defaultFS=file:///"
```

and

```bash
spark-shell --conf "spark.hadoop.fs.defaultFS=file:///"
```

* How to set proxies in Spark:

There is two ways to work with proxies:

1. Add in $SPARK_CONF_DIR/spark-defaults.conf the following line for both `spark.executor.extraJavaOptions` and `spark.driver.extraJavaOptions` variables:

```bash
 -Dhttp.proxyHost=<URL> -Dhttp.proxyPort=<PORT> -Dhttps.proxyHost=<URL> -Dhttps.proxyPort=<PORT>
 ```

e.g.

```bash
# OpenBlas confs
spark.executor.extraJavaOptions=-Dcom.github.fommil.netlib.BLAS=com.github.fommil.netlib.NativeSystemBLAS -Dcom.github.fommil.netlib.LAPACK=com.github.fommil.netlib.NativeSystemLAPACK -Dcom.github.fommil.netlib.ARPACK=com.github.fommil.netlib.NativeSystemARPACK -Dhttp.proxyHost=example.proxy -Dhttp.proxyPort=111 -Dhttps.proxyHost=example.proxy -Dhttps.proxyPort=112

spark.driver.extraJavaOptions=-Dcom.github.fommil.netlib.BLAS=com.github.fommil.netlib.NativeSystemBLAS -Dcom.github.fommil.netlib.LAPACK=com.github.fommil.netlib.NativeSystemLAPACK -Dcom.github.fommil.netlib.ARPACK=com.github.fommil.netlib.NativeSystemARPACK -Dhttp.proxyHost=example.proxy -Dhttp.proxyPort=111 -Dhttps.proxyHost=example.proxy -Dhttps.proxyPort=112
```

2. Give as `conf` parameter the proxies URL and Port.

e.g.

```bash
pyspark --conf "spark.hadoop.fs.defaultFS=file:///" --conf "spark.driver.extraJavaOptions=-Dhttp.proxyHost=example.proxy -Dhttp.proxyPort=111 -Dhttps.proxyHost=example.proxy -Dhttps.proxyPort=112"
```

and

```bash
spark-shell --conf "spark.hadoop.fs.defaultFS=file:///" --conf "spark.driver.extraJavaOptions=-Dhttp.proxyHost=example.proxy -Dhttp.proxyPort=111 -Dhttps.proxyHost=example.proxy -Dhttps.proxyPort=112"
```

***

#### Non functional known issues

* spark-shell:

>There is an exception message `Unrecognized Hadoop major version number: 3.2.0 at org.apache.hadoop.hive.shims.ShimLoader.getMajorVersion`.
This is not a problem, DARS is not using hadoop.hive.shims.
Hive binaries installed from [Apache](http://www.apache.org/dyn/closer.cgi/hive) on Clearlinux + JDK 11 does not work, this is an issue reported on [Jira's Hive](https://issues.apache.org/jira/browse/HIVE-21237) since February.

* pyspark:

>There is an exception message `Exception in thread "Thread-3" java.lang.ExceptionInInitializerError at org.apache.hadoop.hive.conf.HiveConf`
Hive binaries installed from [Apache](http://www.apache.org/dyn/closer.cgi/hive) on Clearlinux + JDK 11 does not work, this is an issue reported on [Jira's Hive](https://issues.apache.org/jira/browse/HIVE-21237) since February.
