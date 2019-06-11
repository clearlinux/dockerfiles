###############################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################
FROM clearlinux:latest
MAINTAINER hongzhan.chen@intel.com

#Install apache-flink bundle
RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add apache-flink $swupd_arg \
        && rm -rf /var/lib/swupd/*
 
# Configure Flink version
ENV FLINK_VERSION=1.7.2

# Prepare environment
ENV FLINK_HOME=/usr/share/flink
ENV PATH=$FLINK_HOME/bin:$PATH

# Prepare to run
RUN mkdir -p /var/log/flink

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 6123 8081
CMD ["help"]
