define apimanager::deploy ( $security, $target, $owner, $group, $amtype ) {

  file {
    $target:
      ensure          => present,
      owner           => $owner,
      group           => $group,
      mode            => '0755',
      sourceselect    => all,
      ignore          => '.svn',
      recurse         => 'remote',
      #notify          => Service["wso2${amtype}"],
      source          => [
                          'puppet:///modules/apimanager/common/configs/',
                          'puppet:///modules/apimanager/common/patches/',
                          "puppet:///modules/apimanager/${amtype}/configs/",
                          "puppet:///modules/apimanager/${amtype}/patches/",
                          #'puppet:///modules/wso2base/configs/',
                          #'puppet:///modules/wso2base/patches/',
                        ],
  }
#          file { "${target}/repository/components/lib/jtds-1.2.8.jar":
#                ensure => absent,
#		require   => File[$target],
#          }
#	
#          file { "${target}/repository/components/dropins/jtds_1.2.8_1.0.0.jar":
#                ensure => absent,
#		require   => File[$target],
#          }
}
