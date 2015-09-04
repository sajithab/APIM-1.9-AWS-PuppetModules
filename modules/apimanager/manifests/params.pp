class apimanager::params {

#  $depsync_svn_repo     = 'https://svn.appfactory.domain.com/wso2/repo/'
  $local_package_dir    = '/mnt/packs'

  $wso2_env_domain	= 'amazonaws.com'
  $am_subdomain		= 'us-east-1.elb'
  $gateway_subdomain	= 'apim-elb-gateway-wkr-1181671605'
  $gateway_internal_subdomain	= 'apim-elb-gateway-wkr-1181671605'
  $gateway_m_subdomain	= 'apim-elb-gateway-mgt-1428223413'
  $keymanager_subdomain = 'apim-elb-keymanager-676219883'
  $pubstore_subdomain   = 'apim-elb-new0-289156670'
  $svn_subdomain	= 'svn'
  $mysql_subdomain	= 'mysql'

  $keymanager_ip	= '192.168.15.191'
  $gateway_m_ip		= '192.168.15.191'
  $gateway_ip		= '192.168.15.191'
  $pubstore_ip		= '192.168.15.191'

  $am_nio_http_port	= '8280'
  $am_nio_https_port	= '8243'


  # Clustering section
  $localmember_port     = '5701'
  $aws_access_key       = '<aws_access_key>'
  $aws_secret_key       = '<aws_secret_key>'
  $aws_security_group   = 'apim-cluster-sg'

  $admin_username       = 'admin'
  $admin_password       = 'admin'

#  # MySQL server configuration details
  $mysql_server         = "apim-db.cd3cwezibdu8.us-east-1.rds.amazonaws.com"
  $mysql_port           = '3306'
  $max_connections      = '100000'
  $max_active           = '50'
  $max_wait             = '60000'

#  # Database details
  $registry_user        = 'wso2'
  $registry_password    = 'ws02.adimn.123'
  $registry_database    = 'WSO2_REGISTRY_DB'

  $userstore_user       = 'wso2'
  $userstore_password   = 'ws02.adimn.123'
  $userstore_database   = 'WSO2_USERSTORE_DB'

  $configdb_user	= 'wso2'
  $configdb_password	= 'ws02.adimn.123'
  $configdb_database	= 'APIM_config_registry'
	
  $apimgt_user		= 'wso2'
  $apimgt_password	= 'ws02.adimn.123'
  $apimgt_database	= 'WSO2AM_DB'
	
  $bam_apim_stat_user		= 'bam_apim_stat'
  $bam_apim_stat_password	= 'bam_apim_stat_db123'
  $bam_apim_stat_database	= 'bam_apim_stat'
	

#  # Depsync settings
  $svn_server		= '10.0.2.12'
  $svn_user             = 'sajith'
  $svn_password         = 'sajith.123'
  $svn_apim_repo	= 'svn/apimrepo'


	# Add required environment variables
        file { '/etc/profile.d/wso2.sh':
                ensure => present,
                source => 'puppet:///modules/apimanager/environment',
        }
}
