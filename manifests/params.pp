class s390utils_cpuplugd::params {

  $service_ensure = running
  $service_enable = true

  # These are the settings right out of /etc/sysconfig/cpuplugd file.

  $cpu_min = 1
  $cpu_max = 0

  # RHEL6 has an update of 5. RHEL7 has update of 1
  $update = $::lsbmajdistrelease ?  {
    6 =>  5,
    7 =>  1,
  }

  $cmm_min = 0
  $cmm_max = 131072

  # This value not available on RHEL7
  $pgscan_k = 'vmstat.pgscan_kswapd_dma + vmstat.pgscan_kswapd_normal + vmstat.pgscan_kswapd_movable'

  $pgscan_d = 'vmstat.pgscan_direct_dma[0] + vmstat.pgscan_direct_normal[0] + vmstat.pgscan_direct_movable[0]'

  # This value not availabe on RHEL7
  $pgscan_k1 = 'vmstat.pgscan_kswapd_dma[1] + vmstat.pgscan_kswapd_normal[1] + vmstat.pgscan_kswapd_movable[1]'

  $pgscan_d1 = 'vmstat.pgscan_direct_dma[1] + vmstat.pgscan_direct_normal[1] + vmstat.pgscan_direct_movable[1]'

  $pgscanrate   = '(pgscan_d - pgscan_d1) / (cpustat.total_ticks[0] - cpustat.total_ticks[1])'

  # RHEL6 only 
  $cache = 'meminfo.Cached + meminfo.Buffers'

  # RHEL7 only
  $avail_cache  = 'meminfo.Cached - meminfo.Shmem'

  $user_0       = '(cpustat.user[0] - cpustat.user[1])'
  $nice_0       = '(cpustat.nice[0] - cpustat.nice[1])'
  $system_0     = '(cpustat.system[0] - cpustat.system[1])'
  $user_2       = '(cpustat.user[2] - cpustat.user[3])'
  $nice_2       = '(cpustat.nice[2] - cpustat.nice[3])'
  $system_2     = '(cpustat.system[2] - cpustat.system[3])'
  $CP_Active0   = '(user_0 + nice_0 + system_0) / (cpustat.total_ticks[0] - cpustat.total_ticks[1])'
  $CP_Active2   = '(user_2 + nice_2 + system_2) / (cpustat.total_ticks[2] - cpustat.total_ticks[3])'
  $CP_ActiveAVG = '(CP_Active0+CP_Active2) / 2'
  $idle_0       = '(cpustat.idle[0] - cpustat.idle[1])'
  $iowait_0     = '(cpustat.iowait[0] - cpustat.iowait[1])'
  $idle_2       = '(cpustat.idle[2] - cpustat.idle[3])'
  $iowait_2     = '(cpustat.iowait[2] - cpustat.iowait[3])'
  $CP_idle0     = '(idle_0 + iowait_0) / (cpustat.total_ticks[0] - cpustat.total_ticks[1])'
  $CP_idle2     = '(idle_2 + iowait_2) / (cpustat.total_ticks[2] - cpustat.total_ticks[3])'
  $CP_idleAVG   = '(CP_idle0 + CP_idle2) / 2'

  $cmm_inc      = 'meminfo.MemFree / 40'
  $cmm_dec      = 'meminfo.MemTotal / 40'

  $hotplug      = '((1 - CP_ActiveAVG) * onumcpus) < 0.08'
  $hotunplug    = '(CP_idleAVG * onumcpus) > 1.15'

  $memplug   = 0
  $memunplug = 0

}
