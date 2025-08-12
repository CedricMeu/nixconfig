{ home-manager, ... }:
{
  home.activation.SETUP_NPMRC = home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    grep -qxF 'prefix = ''${HOME}/.cache/npm' ''${HOME}/.npmrc || echo 'prefix = ''${HOME}/.cache/npm' >> ''${HOME}/.npmrc
    grep -qxF 'color=true' ''${HOME}/.npmrc || echo 'color=true' >> ''${HOME}/.npmrc
  '';
}
