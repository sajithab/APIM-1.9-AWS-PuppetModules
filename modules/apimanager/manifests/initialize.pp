define apimanager::initialize (
  $repo,
  $version,
  $service,
  $local_dir,
  $target,
  $mode,
  $owner,
  $group,
) {

#	file_line { 'host_file_lines':
#		ensure	=> 'present',
#		path 	=> '/etc/hosts',
#		line	=> "dd${::mysql_server}	${::mysql_subdomain}.${::wso2_env_domain}",
#	}

  file { "${local_dir}/wso2${service}-${version}.zip":
                ensure  => present,
                source  => "puppet:///modules/apimanager/distribution/wso2${service}-${version}.zip",
                require => Exec["creating_local_package_repo_for_${name}"];
        }

  exec {
    "creating_target_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command   => "mkdir -p ${target}",
      unless    => "test -d ${target}";

    "creating_local_package_repo_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      unless    => "test -d ${local_dir}",
      command   => "mkdir -p ${local_dir}";

    #"downloading_wso2${service}-${version}.zip_for_${name}":
    #  path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    #  cwd       => $local_dir,
    #  unless    => "test -f ${local_dir}/wso2${service}-${version}.zip",
    #  command   => "wget -q ${repo}/wso2${service}-${version}.zip",
    #  logoutput => 'on_failure',
    #  creates   => "${local_dir}/wso2${service}-${version}.zip",
    #  timeout   => 0,
    #  require   => Exec["creating_local_package_repo_for_${name}",
    #                    "creating_target_for_${name}"];

    "extracting_wso2${service}-${version}.zip_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      unless    => "test -d ${target}/wso2${service}-${version}/repository",
      command   => "unzip ${local_dir}/wso2${service}-${version}.zip",
      logoutput => 'on_failure',
      creates   => "${target}/wso2${service}-${version}/repository",
      timeout   => 0,
      notify    => Exec["setting_permission_for_${name}"],
      require   => File["${local_dir}/wso2${service}-${version}.zip"];

    "setting_permission_for_${name}":
      path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd         => $target,
      command     => "chown -R ${owner}:${group} ${target}/wso2${service}-${version} ;
                      chmod -R 755 ${target}/wso2${service}-${version}",
      logoutput   => 'on_failure',
      timeout     => 0,
      refreshonly => true,
      require     => Exec["extracting_wso2${service}-${version}.zip_for_${name}"];
  }
}
