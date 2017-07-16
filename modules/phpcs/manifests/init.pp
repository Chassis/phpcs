# Install PHPCS
class phpcs (
	$path         = '/vagrant/extensions/phpcs',
	$phpcs_config = sz_load_config()
) {

	if versioncmp( $phpcs_config[php], '5.4') <= 0 {
		$php_package = 'php5'
	} else {
		$php_package = "php${phpcs_config[php]}"
	}

	if ! defined( Package['php-pear'] ) {
		package { 'php-pear':
			ensure  => latest,
			require => Package["$::{php_package_dev}"]
		}
	}

	if ! defined( Package["$::{php_package_dev}"] ) {
		package { "$::{php_package_dev}":
			ensure  => latest,
			require => Package["$::{php_package_common}"]
		}
	}

	exec { 'phpcs install':
		command => 'pear install PHP_CodeSniffer',
		path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
		require => Package[ "$::{php_package_dev}", 'php_pear', "$::{php_package_fpm}" ],
		unless  => 'which phpcs',
		notify  => Service["$::{php_package_fpm}"],
	}

	exec { 'wordpress cs install':
		command => 'git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /vagrant/extensions/phpcs/wpcs && phpcs --config-set installed_paths /vagrant/extensions/phpcs/wpcs',
		path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
		require => [ Package['git-core'], Exec['phpcs install'], File['/vagrant/extensions/phpcs/wpcs'] ]
	}

	file { '/vagrant/extensions/phpcs/wpcs':
		ensure => absent,
		force  => true
	}
}
