# Custom packages 
# They can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'

{ pkgs }: {

  qutebrowser-bin = pkgs.callPackage ./quutebrowser-bin { };

}