class php {
    package { 'php5':
        ensure => present,
    }
}

define php::mod() {
    include php

    package { "php5-${name}":
        ensure => present,
        require => Package['php5'],
    }

    exec { "php5enmod ${name}":
        require => Package["php5-${name}"],
    }
}

class php::extra {
    @php::mod { [
        'mysql',
    ]: }
}
