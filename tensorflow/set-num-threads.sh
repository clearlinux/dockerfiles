#!/bin/sh

# get core numbers
lcores=$(grep "^processor" -c /proc/cpuinfo)  # logical cores
nos=$(lscpu | grep "^Socket(s)" | awk '{print $NF}')  # number of socket
pcps=$(lscpu | grep "^Core(s) per socket" | awk '{print $NF}') # physical cores per socket
htn=$(lscpu | grep "^Thread(s) per core" | awk '{print $NF}')  # hyper threads per core
lcps=$((pcps*htn))  # logical cores per socket
pcores=$(awk 'BEGIN{ x="'$lcores'" / "'$htn'"; printf("%.0f\n", (x == int(x))?x:int(x)+1) }') # physical cores
csets=$(cat /proc/self/status | grep "^Cpus_allowed:" | awk '{print $NF}')  # cpuset-cpus
cfull=$(((1<<lcps) - 1)) # cpus full set
cswn=$(awk 'BEGIN{ x="'$lcores'" / "32"; printf("%.0f\n", (x == int(x))?x:int(x)+1) }') # cpuset word number

# cpu quota
qus=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
pus=$(cat /sys/fs/cgroup/cpu/cpu.cfs_period_us)
# calculate qnums by CPU quota and round up
if [[ $qus != "-1" ]]; then
  qnums=$(awk 'BEGIN{ x="'$qus'" / "'$pus'"; printf("%.0f\n", (x == int(x))?x:int(x)+1) }')
fi

# stat. each socket: logical & physical core numbers
lnums=0; pnums=0; declare -a mask=()
for ((i=0;i<$nos;i++)); do
  si=$((i*pcps))

  let slnums[i]=0; let spnums[i]=0; ml=0;
  for ((j=0;j<cswn;j++)); do
    let k=cswn-j  # reverse order
    smask=$((0x$(cat /sys/devices/system/cpu/cpu${si}/topology/core_siblings | cut -d, -f${k})))
    cssets=$(echo $csets | cut -d, -f${k})
    hcssets=$((0x${cssets}))
    ssets=$(($smask & $hcssets))

    if ((ssets != 0)); then
      n=$ssets
      while (( n != 0 )); do
        m=$((n & (~n + 1)))
        snth=$(awk 'BEGIN{ x='$m'; printf("%.0f\n", log(x)/log(2))}')
        nth=$((snth+ml))
        # get hyperthread sibling topology
        t1=$(awk -F, '{print $1}' /sys/devices/system/cpu/cpu${nth}/topology/thread_siblings_list)
        t2=$(awk -F, '{print $2}' /sys/devices/system/cpu/cpu${nth}/topology/thread_siblings_list)

        # by cpuset-cpus, stat. assigned physical & logical cores per socket
        if ((mask[t1] !=1 && mask[t2] != 1)); then
	  ((mask[t1]=1))
	  ((mask[t2]=1))
          ((spnums[i]++))
          ((pnums++))
	fi

        n=$((n - m))
        ((slnums[i]++))
        ((lnums++))
      done
      # hexadecimal mask length
      ((ml+=${#cssets}*4))
    fi
  done
done

nums=$lnums
# cpu quota
if [[ ! -z $qnums ]]; then
  nums=$(((qnums < nums)?qnums:nums))
fi

export TF_NUM_THREADS=$nums
