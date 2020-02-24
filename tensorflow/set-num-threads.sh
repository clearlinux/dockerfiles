#!/bin/sh

# get core numbers
lcores=$(grep "^processor" -c /proc/cpuinfo)
htn=$(lscpu | grep "^Thread(s) per core" | awk '{print $NF}')
pcores=$(awk 'BEGIN{ x="'$lcores'" / "'$htn'"; printf("%.0f\n", (x == int(x))?x:int(x)+1) }')
csets=$((0x$(cat /proc/self/status | grep "^Cpus_allowed:" | awk '{print $NF}')))
cfull=$(((1<<lcores) - 1))

# cpu quota
qus=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
pus=$(cat /sys/fs/cgroup/cpu/cpu.cfs_period_us)
# calculate qnums by CPU quota and round up
if [[ $qus != "-1" ]]; then
  qnums=$(awk 'BEGIN{ x="'$qus'" / "'$pus'"; printf("%.0f\n", (x == int(x))?x:int(x)+1) }')
fi

if (( csets == cfull )); then
  nums=$pcores
else
  # if set cpu affinity
  # get hyperthread sibling topology
  st=0; i=0
  until [[ $st > 0 || $i > $lcores ]]; do
    if [ -r /sys/devices/system/cpu/cpu$i/topology/thread_siblings_list ]; then
      x=$(awk -F, '{print $1}' /sys/devices/system/cpu/cpu$i/topology/thread_siblings_list)
      y=$(awk -F, '{print $2}' /sys/devices/system/cpu/cpu$i/topology/thread_siblings_list)
      st=$((y-x))
    fi
    ((i++))
  done

  # calculate logical & physical core number by the toplogy
  lnums=0; pnums=0; mask=0; n=csets
  while (( n != 0 ))
  do
    m=$((n & (~n + 1)))
    if (( (m & mask) == 0 )); then
      mask=$((mask|m|m<<st))
      ((pnums++))
    fi

    n=$((n - m))
    ((lnums++))
  done

  # v2: cpuset-k guar-ex
  if (( qnums == lnums )); then
    if (( (lnums < pcores && lnums % 2 != 0) || pnums == 1 )); then
      nums=$pnums
    else
      nums=$lnums
    fi
  else
    # cpuset-d
    nums=$pnums
  fi
fi

# calculate nums by assigned logical core and total physical core numbers
if [ ! -z $qnums ]; then
  nums=$(((qnums < nums)?qnums:nums))
fi

export OMP_NUM_THREADS=$nums
