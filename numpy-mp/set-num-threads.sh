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

# all cpus
if ((lnums==lcores)); then
  allc=1
else
  allc=0
fi

nums=$pnums
# cpu quota
if [[ ! -z $qnums ]]; then
  if [[ ${NUMPY_MP_PROCESS_MODEL}x = "ASYMMETRY"x && $qnums -gt $lcps && $nos -gt 1 ]]; then
    nums=$qnums
  else
    nums=$(((qnums < nums)?qnums:nums))
  fi
fi

# default: single process w/o numa node affinity
if [[ ${NUMPY_MP_PROCESS_MODEL}x != "SYMMETRY"x && ${NUMPY_MP_PROCESS_MODEL}x != "ASYMMETRY"x && ${NUMPY_MP_PROCESS_MODEL}x != "SINGLE"x ]]; then
  unset NUMPY_MP_PROCESS_NUM
# for multi-sockets case
elif [[ $nos -gt 1 && $nums -gt 1 ]]; then
  declare -a p_ompnums=()
  declare -a p_tscores=()

  # all cpus
  if [[ $allc -eq 1 ]]; then
    # each process spawns nearly same no. of OMP threads running on each socket
    if [[ ${NUMPY_MP_PROCESS_MODEL}x = "SYMMETRY"x ]]; then
      if [[ $nums -ge $nos ]]; then
        npnum=$nos
      else
        npnum=$nums
      fi

      runums=$(awk 'BEGIN{ x="'$nums'" / "'$npnum'"; printf("%.0f\n", (x == int(x))?x:int(x)+1) }')
      rdnums=$((nums/npnum))
      if ((runums != rdnums)); then
        psum=$nums; divi=0
        for ((i=1;i<$npnum;i++)); do
          if ((divi==0)); then
	    p_ompnums+=($(printf '%01d' ${runums}))
            ((psum-=runums))
	  fi
	  if (((npnum-i)*rdnums == psum || divi == 1)); then
	    p_ompnums+=($(printf '%01d' ${rdnums}))
	    divi=1
	  fi
        done
      else
        for ((i=0;i<$npnum;i++)); do
          p_ompnums+=($(printf '%01d' ${runums}))
        done
      fi
      nums=$runums

      for ((i=0;i<$npnum;i++)); do
        si=$(((nos-i-1)*pcps))
        scores=$(cat /sys/devices/system/cpu/cpu${si}/topology/core_siblings_list)
        p_tscores+=(${scores})
      done
    # according to assigned resource, processes spawn OMP threads running on socket by socket order
    elif [[ ${NUMPY_MP_PROCESS_MODEL}x = "ASYMMETRY"x ]]; then
      npnum=$(awk 'BEGIN{ x="'$nums'" / "'$lcps'"; printf("%.0f\n", (x == int(x))?x:int(x)+1) }')
      rem=$((${nums} % ${lcps}))
      for ((i=0;i<$npnum;i++)); do
        if ((rem !=0 && i == npnum-1)); then
	  p_ompnums+=($(printf '%01d' $(((${rem} > ${pcps})?${pcps}:${rem}))))
        else
          p_ompnums+=($(printf '%01d' ${pcps}))
        fi
        si=$(((nos-i-1)*pcps))
        scores=$(cat /sys/devices/system/cpu/cpu${si}/topology/core_siblings_list)
        p_tscores+=(${scores})
      done
      nums=${p_ompnums[0]}
    # single process w/i numa node affinity
    elif [[ ${NUMPY_MP_PROCESS_MODEL}x = "SINGLE"x ]]; then
      ((npnum=1))
      nums=$(((nums > pcps)?pcps:nums))
      p_ompnums+=($(printf '%01d' ${nums}))
      si=$(((nos-1)*pcps))
      scores=$(cat /sys/devices/system/cpu/cpu${si}/topology/core_siblings_list)
      p_tscores+=(${scores})
    fi
  else # cpuset-cpus
    if [[ ${NUMPY_MP_PROCESS_MODEL}x = "SINGLE"x ]]; then
      ((npnum=1))
      # for k8s system-reserved
      if ((qnums==lnums && qnums >= lcps)); then
        p_ompnums+=($(printf '%01d' ${spnums[1]}))
        si=$((1*pcps))
      else
        p_ompnums+=($(printf '%01d' ${spnums[0]}))
        si=$((0*pcps))
      fi
      scores=$(cat /sys/devices/system/cpu/cpu${si}/topology/core_siblings_list)
      p_tscores+=(${scores})
    else
      npnum=0
      # for k8s cpu allocation order
      for ((i=nos-1;i>=0;i--)); do
        si=$((i*pcps))

        if ((slnums[i] > 0 && spnums[i] > 0)); then
          scores=$(cat /sys/devices/system/cpu/cpu${si}/topology/core_siblings_list)
          p_tscores+=(${scores})

	  p_ompnums+=($(printf '%01d' ${spnums[i]}))
          ((npnum++))
        fi
      done
    fi
    nums=${p_ompnums[0]}
  fi
  NUMPY_MP_PROCESS_NUM=$npnum
fi

if [[ ! -z NUMPY_MP_PROCESS_NUM ]]; then
  export NUMPY_MP_PROCESS_NUM
  for ((i=1;i<=npnum;i++)); do
    export NUMPY_MP_PROCESS_CORES$i=${p_tscores[i-1]}
  done

  if [[ ! -z p_ompnums ]]; then
    for ((i=1;i<=npnum;i++)); do
      export NUMPY_MP_PROCESS_OMPNUM$i=${p_ompnums[i-1]}
    done
  fi
fi

export OMP_NUM_THREADS=$nums
