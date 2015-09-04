class apimanager::gateway(
  $version            = undef,
  $offset             = 0,
  $services           = undef,
  $members            = undef,
  $clustering         = true,
  $sub_cluster_domain = "worker",
  $maintenance_mode   = 'zero',
  $localmember_port   = '5701',
  $depsync            = false,
  $cloud              = false,
  $owner              = '',
  $group              = '',
  $target             = '/mnt',
  $auto_scaler        = false,
  $auto_failover      = false,
) inherits params {

  $deployment_code  = 'apimanager'
  $service_code     = 'am'
  $amtype           = 'gateway'
  $carbon_home      = "${target}/wso2${service_code}-${version}"

  $service_templates  = [
    'conf/api-manager.xml',
    'conf/carbon.xml',
    'conf/registry.xml',
    'conf/axis2/axis2.xml',
    'deployment/server/synapse-configs/default/api/_TokenAPI_.xml',
    'deployment/server/synapse-configs/default/api/_RevokeAPI_.xml',
    'deployment/server/synapse-configs/default/api/_AuthorizeAPI_.xml',
  ]

  $common_templates = [
    'conf/user-mgt.xml',
    'conf/datasources/master-datasources.xml',
  ]

  tag ('apimanager')

  apimanager::clean {
    $deployment_code:
      mode   => $maintenance_mode,
      target => $carbon_home,
  }

  apimanager::initialize {
    $deployment_code:
      repo      => $package_repo,
      version   => $version,
      service   => $service_code,
      local_dir => $local_package_dir,
      target    => $target,
      mode      => $maintenance_mode,
      owner     => $owner,
      group     => $group,
      require   => Clean[$deployment_code],
  }

  apimanager::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    amtype   => $amtype,
    require  => Initialize[$deployment_code],
  }

  push_templates {
    $service_templates:
      target     => $carbon_home,
      directory  => "$deployment_code/$deployment_code",
      require    => Deploy[$deployment_code];

    $common_templates:
      target     => $carbon_home,
      directory  => "$deployment_code/common",
      require    => Deploy[$deployment_code];
  }

  file { "/etc/init.d/wso2${amtype}":
    ensure    => present,
    owner     => $owner,
    group     => $group,
    mode      => '0775',
    content   => template("${deployment_code}/wso2${service_code}.erb"),
  }

  service { "wso2${amtype}":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [
      Initialize[$deployment_code],
      Deploy[$deployment_code],
      Push_templates[$service_templates],
      File["/etc/init.d/wso2${amtype}"],
    ],
  }
}
