# 2415225178811784
{
    inputs = { } ;
    outputs =
        { self } :
            {
                lib =
                    { input ? x : x , output ? x : x } :
                        let
                            implementation =
                                { lib , pkgs , ... } @module :
                                    let
                                        exploded = ./node_modules.exploded ;
                                        identified = input module ;
                                        in
                                            with identified ;
                                                {
                                                    config.environment.sessionVariables.FETCH_BCRYPT= "bcrypt = ^5.1.1" ;
                                                    options.node-packages.bcrypt =
                                                        lib.mkOption
                                                            {
                                                                default =
                                                                    pkgs.runCommand
                                                                        "node-package"
                                                                        {
                                                                            nativeBuildInputs =
                                                                                [
                                                                                    (
                                                                                        config.tree-serialization.implode
                                                                                            {
                                                                                                input = exploded ;
                                                                                                name = "implode" ;
                                                                                                output = "$OUT" ;
                                                                                            }
                                                                                    )
                                                                                ] ;
                                                                        }
                                                                        ''
                                                                            export OUT="$out"
                                                                            implode
                                                                        '' ;
                                                                type = lib.types.package ;
                                                            } ;
                                                } ;
                            in
                                {
                                    check = null ;
                                    checks = [ ] ;
                                    implementation = output implementation
                                    imports = [ ] ;
                                } ;
            } ;
}
