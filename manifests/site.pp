node /pubstore/ {
        package {["nmap","telnet","traceroute","unzip"]:
                ensure => latest,
        #        allow_virtual => false,
        }

        #Install Java in the VM
        include apimanager::java

        class {"apimanager::pubstore":
                version            => "1.9.0",
                offset             => 0,
                localmember_port   => 5701,
                clustering         => 'true',
                owner              => "ubuntu",
                group              => "ubuntu",
                sub_cluster_domain => "mgt",
                target             => "/mnt/${ipaddress_eth1}/pubstore",
                require => [
                       Class['apimanager::java']
                        ],
        }
}
node /gateway/ {
        package {["nmap","telnet","traceroute","unzip"]:
                ensure => latest,
                #allow_virtual => false,
        }

        #Install Java in the VM
        include apimanager::java

        class {"apimanager::gateway":
    		version            => "1.9.0",
    		offset             => 0,
    		localmember_port   => 5701,
    		clustering         => 'true',
    		owner              => "ubuntu",
    		group              => "ubuntu",
    		sub_cluster_domain => "worker",
    		target             => "/mnt/${ipaddress_eth1}/gateway",
		require => [
                       Class['apimanager::java']
                        ],
  }

}

node /gate-way-m/ {
        package {["nmap","telnet","traceroute","unzip"]:
                ensure => latest,
                #allow_virtual => false,
        }

        #Install Java in the VM
        include apimanager::java

        class {"apimanager::gate-way-m":
    		version            => "1.9.0",
    		offset             => 0,
    		localmember_port   => 5701,
    		clustering         => 'true',
    		owner              => "ubuntu",
    		group              => "ubuntu",
    		sub_cluster_domain => "mgt",
    		target             => "/mnt/${ipaddress_eth1}/gate-way-m",
		require => [
                       Class['apimanager::java']
                        ],
  }

}

node /keymanager/ {
        package {["nmap","telnet","traceroute","unzip"]:
                ensure => latest,
                #allow_virtual => false,
        }

        #Install Java in the VM
        include apimanager::java

        class {"apimanager::keymanager":
                version            => "1.9.0",
                offset             => 0,
                localmember_port   => 5701,
                clustering         => 'true',
                owner              => "ubuntu",
                group              => "ubuntu",
                sub_cluster_domain => "mgt",
                target             => "/mnt/${ipaddress_eth1}/keymanager",
                require => [
                       Class['apimanager::java']
                        ],
  }

}
