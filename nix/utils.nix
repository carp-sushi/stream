let
  findHaskellPackages = root:
    let items = builtins.readDir root;
      fn = file: type:
      if type == "directory" && isNull (builtins.match "\\..*" file) && !(builtins.elem file ["dist" "dist-new" "dist-newstyle"])
        then (findHaskellPackages (root + (/. + file)))
        else (
          if type == "regular" then (
            let m = (builtins.match "(.*)\\.cabal" file); in
              if !(isNull m)
                then { "${builtins.elemAt m 0}" = root; }
                else {}
          )
          else {}
        );
    in
      builtins.foldl' (x: y: x // y) {} (builtins.attrValues (builtins.mapAttrs fn items));
in {
  inherit findHaskellPackages;
}
