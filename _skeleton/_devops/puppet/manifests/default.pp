# default executable path
Exec {
    path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
}

# silence the annoyance about the puppet group
group { 'puppet':
    ensure => 'present',
}

# ensure local apt cache index is up to date
exec { 'apt-get update':
}

# ensure apt-get update run before all other Package resource
Exec['apt-get update'] -> Package <| |>

class tools {
    $packages = [
        'vim',
        'curl',
        'htop',
    ]

    package { $packages:
        ensure => present,
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
