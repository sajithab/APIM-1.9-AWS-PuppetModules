node 'vll-uvdev-wso2-api-ps1' {
        package {["nmap","telnet","vim-enhanced","traceroute","unzip"]:
                ensure => latest,
                allow_virtual => false,
        } 

	#Install Java in the VM
        include apimanager::java

	class {"apimanager::pubstore":
   		version            => "1.8.0",
    		offset             => 0,
    		localmember_port   => 4000,
    		clustering         => 'false',
    		owner              => "wso2",
    		group              => "wso2",
    		sub_cluster_domain => "mgt",
    		target             => "/mnt/${ipaddress_eth1}/pubstore",
		require => [
                       Class['apimanager::java']
                        ],
  	}
}

node 'vll-uvdev-wso2-api-gw1', 'vll-uvdev-wso2-api-gw2' {
        package {["nmap","telnet","vim-enhanced","traceroute","unzip"]:
                ensure => latest,
                allow_virtual => false,
        }

        #Install Java in the VM
        include apimanager::java

        class {"apimanager::gateway":
    		version            => "1.8.0",
    		offset             => 0,
    		localmember_port   => 4000,
    		clustering         => 'true',
    		owner              => "wso2",
    		group              => "users",
    		sub_cluster_domain => "worker",
    		members            => {
      			"192.168.15.194" => '4000',
      			"192.168.15.195" => '4000',
			"192.168.15.199" => '4000',
    		},
    		target             => "/mnt/${ipaddress_eth1}/gateway",
		require => [
                       Class['apimanager::java']
                        ],
  }

}

node 'vll-uvdev-wso2-svn1' {
        package {["nmap","telnet","vim-enhanced","traceroute","unzip"]:
                ensure => latest,
                allow_virtual => false,
        }

        #Install Java in the VM
        include apimanager::java

        class {"apimanager::gateway_m":
    		version            => "1.8.0",
    		offset             => 0,
    		localmember_port   => 4000,
    		clustering         => 'true',
    		owner              => "wso2",
    		group              => "users",
    		sub_cluster_domain => "mgt",
    		members            => {
      			"192.168.15.194" => '4000',
      			"192.168.15.195" => '4000',
      			"192.168.15.199" => '4000',
    		},
    		target             => "/mnt/${ipaddress_eth1}/gateway_m",
		require => [
                       Class['apimanager::java']
                        ],
  }

}

node 'vll-uvdev-wso2-api-km1','vll-uvdev-wso2-api-km2' {
        package {["nmap","telnet","vim-enhanced","traceroute","unzip"]:
                ensure => latest,
                allow_virtual => false,
        }

        #Install Java in the VM
        include apimanager::java

        class {"apimanager::keymanager":
                version            => "1.8.0",
                offset             => 0,
                localmember_port   => 4000,
                clustering         => 'true',
                owner              => "wso2",
                group              => "users",
                sub_cluster_domain => "mgt",
                members            => {
                        "192.168.15.196" => '4000',
                        "192.168.15.197" => '4000',
                },
                target             => "/mnt/${ipaddress_eth1}/keymanager",
                require => [
                       Class['apimanager::java']
                        ],
  }

}
