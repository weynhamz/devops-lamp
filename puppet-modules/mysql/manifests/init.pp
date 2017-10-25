class mysql {
    include apt

    package { 'mysql-server':
        ensure => present,
        require => Exec['apt-get update'],
    }

    service { 'mysql':
        ensure => running,
        require => Package['mysql-server'],
    }
}
