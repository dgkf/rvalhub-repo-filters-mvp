# use the project directory (./src/contrib) to spoof a remote repository
options(repos = c("Local Example Repo" = "file:."))

# by default, we set a "low risk only" filter (see .Rprofile)
packages <- available.packages()
nrow(packages)  # 5 "low risk" packages

# installing a package with known vulnerabilities will abort installation
install.packages("options")
#> Security vulnerabilities found in packages to be installed.
#> To proceed with installation, re-run with `accept_vulnerabilities = TRUE`
#> 
#> ── Vulnerability overview ──
#> 
#> ℹ 1 package was scanned
#> ℹ 1 package was found in the Sonatype database
#> ℹ 1 package had known vulnerability
#> ℹ A total of 1 known vulnerability was identified
#> ℹ See https://github.com/sonatype-nexus-community/oysteR/ for details.



# we can remove the default and permit any package to show unfiltered results
options(available_packages_filters = NULL)

packages <- available.packages()
nrow(packages)  # 17 total available packages


