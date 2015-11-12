# s390utils_cpuplugd.pp
# Set up cpuplugd and service.
#
class s390utils_cpuplugd (

  $service_ensure = $::s390utils_cpuplugd::params::service_ensure,
  $service_enable = $::s390utils_cpuplugd::params::service_enable,
 
 # Both RHEL6 and RHEL7 settings
  $cpu_min    = $::s390utils_cpuplugd::params::cpu_min,
  $cpu_max    = $::s390utils_cpuplugd::params::cpu_max,
  $update    = $::s390utils_cpuplugd::params::update,
  $cmm_min    = $::s390utils_cpuplugd::params::cmm_min,
  $cmm_max    = $::s390utils_cpuplugd::params::cmm_max,

  # RHEL6 only
  $pgscan_k   = $::s390utils_cpuplugd::params::pgscan_k,
  $pgscan_k1  = $::s390utils_cpuplugd::params::pgscan_k1,

  # Both RHEL6 and RHEL7 settings
  $pgscan_d   = $::s390utils_cpuplugd::params::pgscan_d,
  $pgscan_d1  = $::s390utils_cpuplugd::params::pgscan_d1,
  $pgscanrate = $::s390utils_cpuplugd::params::pgscanrate,

  # RHEL6 only
  $cache     = $::s390utils_cpuplugd::params::cache,

  # RHEL7 only
  $avail_cache  = $::s390utils_cpuplugd::params::avail_cache,
  $user_0      = $::s390utils_cpuplugd::params::user_0,
  $nice_0      = $::s390utils_cpuplugd::params::nice_0,
  $system_0    = $::s390utils_cpuplugd::params::system_0,
  $user_2      = $::s390utils_cpuplugd::params::user_2,
  $nice_2      = $::s390utils_cpuplugd::params::nice_2,
  $system_2    = $::s390utils_cpuplugd::params::system_2,
  $CP_Active0   = $::s390utils_cpuplugd::params::CP_Active0,
  $CP_Active2   = $::s390utils_cpuplugd::params::CP_Active2,
  $CP_ActiveAVG = $::s390utils_cpuplugd::params::CP_ActiveAVG,
  $idle_0      = $::s390utils_cpuplugd::params::idle_0,
  $iowait_0    = $::s390utils_cpuplugd::params::iowait_0,
  $idle_2      = $::s390utils_cpuplugd::params::idle_2,
  $iowait_2    = $::s390utils_cpuplugd::params::iowait_2,
  $CP_idle0    = $::s390utils_cpuplugd::params::CP_idle0,
  $CP_idle2    = $::s390utils_cpuplugd::params::CP_idle2,
  $CP_idleAVG   = $::s390utils_cpuplugd::params::CP_idleAVG,

  # Both RHEL6 and RHEL7 settings
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
    content =>   template('s390utils_cpuplugd/cpuplugd.erb'),

  }

  service { 'cpuplugd':
    ensure    =>  $service_ensure,
    subscribe => File['/etc/sysconfig/cpuplugd'],
    enable    =>  $service_enable,
  }

  package { 's390utils-cpuplugd':
    ensure  =>  installed,
  }

  file { '/etc/init.d/cpuplugd':
    notify  => Service['cpuplugd'],  # this sets up the relationship
    mode    => 755,
    owner   => 'root',
    group   => 'root',
    require => Package['s390utils-cpuplugd'],
    content => file('s390utils_cpuplugd/cpuplugd'),
  }

}
