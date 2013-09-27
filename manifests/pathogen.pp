##
class dev_env::pathogen (
  $homedir = '/root',
  $pathogen_url = 'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
  ) {

  $autoloaddir = "${homedir}/.vim/autoload"

  file { $autoloaddir:
    ensure  => directory,
    require => File[ "${homedir}/.vim" ],
  }

  exec { "fetch ${pathogen_url}":
    path    => ['/bin', '/usr/bin', 'sbin', '/usr/sbin'],
    command => "curl -Sso ${autoloaddir}/pathogen.vim ${pathogen_url}",
    require => File[ $autoloaddir ],
  }

  file { "${homedir}/.vimrc":
    ensure => file,
    source => 'puppet:///modules/dev_env/vimrc',
  }
}
