class apache {
    include apt

    package { 'apache2':
        ensure => present,
        require => Exec['apt-get update'],
    }

    service { 'apache2':
        ensure => running,
        require => Package['apache2'],
    }

    file { '/etc/apache2/sites-enabled/000-default.conf':
        ensure => absent,
        notify => Service['apache2'],
        require => Package['apache2'],
    }
}

define apache::mod() {
    include apache

    file { "/etc/apache2/mods-enabled/${name}.load":
        ensure => link,
        target => "../mods-available/${name}.load",
        notify => Service['apache2'],
        require => Package['apache2'],
    }
}

define apache::conf() {
    include apache

    file { "/etc/apache2/conf-enabled/${name}":
        ensure => link,
        target => "../conf-available/${name}",
        notify => Service['apache2'],
        require => [
            File["/etc/apache2/conf-available/${name}"],
            Package['apache2'],
        ]
    }
}

define apache::vhost() {
    include apache

    file {
        "/etc/apache2/sites-enabled/${name}.conf":
            ensure => link,
            target => "../sites-available/${name}.conf",
            notify => Service['apache2'],
            require => File["/etc/apache2/sites-available/${name}.conf"];

        "/etc/apache2/sites-available/${name}.conf":
            source => 'puppet:///modules/apache/vhosts/sample.conf',
            require => Package['apache2'];
    }
}
