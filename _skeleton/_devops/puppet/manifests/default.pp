# default executable path
Exec {
    path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
}

# silence the annoyance about the puppet group
group { 'puppet':
    ensure => 'present',
}

class apt {
    # ensure local apt cache index is up to date
    exec { 'apt-get update':
    }
}

class tools {
    include apt

    $packages = [
        'vim',
        'curl',
        'htop',
    ]

    package { $packages:
        ensure => present,
        require => Exec['apt-get update'],
    }
}

class project {
    include apache

    include php

    include php::extra

    include mysql

    realize Php::Mod['mysql']

    file { '/var/www/@@PROJECT@@':
        ensure => directory,
        require => Package['apache2'],
    }

    apache::vhost { ['@@PROJECT@@']: }
}

include tools, project
