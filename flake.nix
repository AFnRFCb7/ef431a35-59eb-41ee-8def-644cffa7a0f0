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
                                                    options.nodejs =
                                                        {
                                                            fetchers.bcrypt =
                                                                lib.mkOption
                                                                    {
                                                                        default = config.nodejs.fetch { name = "bcrypt" ; nodejs = pkgs.nodejs_22 ; version-spec = "%5.1.1" ; } ;
                                                                        type = lib.types.package ;
                                                                    } ;
                                                            packages.bcrypt =
                                                                lib.mkOption
                                                                    {
                                                                        default = config.nodejs.package { exploded = ./node_modules.exploded ; } ;
                                                                        type = lib.types.package ;
                                                                    } ;
                                                        } ;
                                                } ;
                            in
                                {
                                    check = null ;
                                    checks = [ ] ;
                                    implementation = output implementation ;
                                    imports = [ ] ;
                                } ;
            } ;
}
