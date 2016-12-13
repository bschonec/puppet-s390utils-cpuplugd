class s390utils_cpuplugd (

 $service_ensure = $::s390utils_cpuplugd::params::service_ensure,
 $service_enable = $::s390utils_cpuplugd::params::service_enable,
 
 # both rhel6 and rhel7 settings
 $cpu_min    = $::s390utils_cpuplugd::params::cpu_min,
 $cpu_max    = $::s390utils_cpuplugd::params::cpu_max,
 $update     = $::s390utils_cpuplugd::params::update, 
 $cmm_min    = $::s390utils_cpuplugd::params::cmm_min,
 $cmm_max    = $::s390utils_cpuplugd::params::cmm_max,
 
 # rhel6 only
 $pgscan_k   = $::s390utils_cpuplugd::params::pgscan_k,
 $pgscan_k1  = $::s390utils_cpuplugd::params::pgscan_k1,
 
 # both rhel6 and rhel7 settings
 $pgscan_d   = $::s390utils_cpuplugd::params::pgscan_d,
 $pgscan_d1  = $::s390utils_cpuplugd::params::pgscan_d1,
 $pgscanrate = $::s390utils_cpuplugd::params::pgscanrate,
 
 # rhel6 only
 $cache      = $::s390utils_cpuplugd::params::cache,
 
 # rhel7 only
 $avail_cache  = $::s390utils_cpuplugd::params::avail_cache,
 $user_0       = $::s390utils_cpuplugd::params::user_0,
 $nice_0       = $::s390utils_cpuplugd::params::nice_0,
 $system_0     = $::s390utils_cpuplugd::params::system_0,
 $user_2       = $::s390utils_cpuplugd::params::user_2,
 $nice_2       = $::s390utils_cpuplugd::params::nice_2,
 $system_2     = $::s390utils_cpuplugd::params::system_2,
 $cp_active0   = $::s390utils_cpuplugd::params::cp_active0,
 $cp_active2   = $::s390utils_cpuplugd::params::cp_active2,
 $cp_activeavg = $::s390utils_cpuplugd::params::cp_activeavg,
 $idle_0       = $::s390utils_cpuplugd::params::idle_0,
 $iowait_0     = $::s390utils_cpuplugd::params::iowait_0,
 $idle_2       = $::s390utils_cpuplugd::params::idle_2,
 $iowait_2     = $::s390utils_cpuplugd::params::iowait_2,
 $cp_idle0     = $::s390utils_cpuplugd::params::cp_idle0,
 $cp_idle2     = $::s390utils_cpuplugd::params::cp_idle2,
 $cp_idleavg   = $::s390utils_cpuplugd::params::cp_idleavg,
 
 # both rhel6 and rhel7 settings
 $cmm_inc    = $::s390utils_cpuplugd::params::cmm_inc,
 $cmm_dec    = $::s390utils_cpuplugd::params::cmm_dec,
 $hotplug    = $::s390utils_cpuplugd::params::hotplug,
 $hotunplug  = $::s390utils_cpuplugd::params::hotunplug,
 $memplug    = $::s390utils_cpuplugd::params::memplug,
 $memunplug  = $::s390utils_cpuplugd::params::memunplug,
 
 )
 inherits ::s390utils_cpuplugd::params {
 
 file { '/etc/sysconfig/cpuplugd':
   ensure  =>  file,
   mode    =>  '644',
   owner   =>  'root',
   group   =>  'root',
   content =>   template("s390utils_cpuplugd/cpuplugd.erb"),
 }
 
 service { 'cpuplugd':
   subscribe =>  File["/etc/sysconfig/cpuplugd"],
   ensure    =>  $service_ensure,
   enable    =>  $service_enable,
 } 
 
 package { 's390utils-cpuplugd':
   ensure  =>  installed,
 }
 
}
