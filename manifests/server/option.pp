# == Define samba::server::option
#
define samba::server::option (
  $value = '',
  $target = $samba::server::target,
) {
  $incl    = $samba::server::incl
  $context = $samba::server::context

  $changes = $value ? {
    ''      => "rm ${target}/${name}",
    default => "set \"${target}/${name}\" \"${value}\"",
  }

  augeas { "samba-${name}":
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => $changes,
    require => Augeas['global-section'],
    notify  => Class['Samba::Server::Service']
  }
}
