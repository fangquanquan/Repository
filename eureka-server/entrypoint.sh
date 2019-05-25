#!/usr/bin/env bash

# 预设保留内存值
RESERVED_MEGABYTES=64

# 虚拟机固定参数
JAVA_OPTS="-XX:+AggressiveOpts -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Djava.security.egd=file:/dev/./urandom"

# 检测容器内存限制值
LIMIT_IN_BYTES=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)

# 如果启动容器时限制了内存参数则配置Java堆内存参数
if [ "${LIMIT_IN_BYTES}" -ne "9223372036854771712" ]
then

  LIMIT_IN_MEGABYTES=$(expr ${LIMIT_IN_BYTES} \/ 1048576)

  if [ ${RESERVED_MEGABYTES} -ge $(expr ${LIMIT_IN_MEGABYTES} \/ 4) ]
  then
    HEAP_SIZE=$(expr ${LIMIT_IN_MEGABYTES} \* 3 \/ 4)
  else
    HEAP_SIZE=$(expr ${LIMIT_IN_MEGABYTES} - ${RESERVED_MEGABYTES})
  fi

  JAVA_OPTS="${JAVA_OPTS} -Xms${HEAP_SIZE}m -Xmx${HEAP_SIZE}m"

fi

exec java \
  ${JAVA_OPTS} \
  -jar ${JAR_FILE}